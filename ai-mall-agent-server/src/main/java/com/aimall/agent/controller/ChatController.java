package com.aimall.agent.controller;

import com.aimall.agent.agent.CustomerServiceAgent;
import com.aimall.agent.common.Result;
import com.aimall.agent.context.ChatPrincipalContext;
import com.aimall.agent.entity.AiSession;
import com.aimall.agent.service.AiSessionService;
import com.aimall.agent.service.ChatMemoryService;
import com.aimall.agent.service.ChatStopRegistry;
import com.aimall.agent.service.QuotaService;
import com.aimall.agent.sse.SseEventSender;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import reactor.core.Disposable;
import reactor.core.publisher.SignalType;

import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * AI 对话接口：SSE 流式对话与停止生成
 *
 * <p>处理链路（顺序即防线顺序）：
 * <p>1. 限额检查（进入任何模型调用之前，超限吐 quota_exceeded）
 * <p>2. 会话获取/创建 + 用户消息落库 + assistant 占位（GENERATING）
 * <p>3. P1 阶段直连客服 Agent（Coordinator 路由在 P2 接入后替换此处）
 * <p>4. 流式推送 text-delta；结束/停止/异常分别以 COMPLETED/STOPPED/FAILED 回填落库并写短期记忆
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@RestController
@RequestMapping("/agent/chat")
@RequiredArgsConstructor
public class ChatController {

    /** SSE 超时：5 分钟（长回答冗余） */
    private static final long SSE_TIMEOUT_MS = 5 * 60 * 1000L;

    private final AiSessionService aiSessionService;
    private final QuotaService quotaService;
    private final ChatMemoryService chatMemoryService;
    private final ChatStopRegistry chatStopRegistry;
    private final CustomerServiceAgent customerServiceAgent;

    /**
     * 流式对话（body: {sessionId?, message}）
     */
    @PostMapping(value = "/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public SseEmitter stream(@RequestBody Map<String, String> body) {
        SseEmitter emitter = new SseEmitter(SSE_TIMEOUT_MS);
        SseEventSender sender = new SseEventSender(emitter);

        String message = body.get("message");
        if (!StringUtils.hasText(message)) {
            sender.error("invalid_param", "消息内容不能为空");
            return emitter;
        }

        // 1. 限额（链路最前，游客/登录分维度）
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        if (!quotaService.tryConsume()) {
            sender.error("quota_exceeded", principal.isLogin()
                    ? "今日对话额度已用完，明天再来吧" : "今日游客额度已用完，登录后可提升额度");
            return emitter;
        }

        // 2. 会话与消息落库（异常必须以 SSE error 事件返回：本接口 produces 为 event-stream，
        //    逃逸到全局 JSON 异常处理器会因内容协商失败变成 406）
        AiSession session;
        String userMessageId;
        String assistantMessageId;
        try {
            session = aiSessionService.getOrCreateSession(body.get("sessionId"), message);
            userMessageId = aiSessionService.saveUserMessage(session.getSessionId(), message);
            assistantMessageId = aiSessionService.saveAssistantPlaceholder(
                    session.getSessionId(), userMessageId, CustomerServiceAgent.AGENT_CODE);
            chatMemoryService.append(session.getSessionId(), "user", message);
        } catch (IllegalArgumentException e) {
            sender.error("invalid_session", e.getMessage());
            return emitter;
        } catch (Exception e) {
            log.error("对话前置处理失败", e);
            sender.error("server_error", "系统繁忙，请稍后再试");
            return emitter;
        }

        sender.start(session.getSessionId(), assistantMessageId);
        sender.agent(CustomerServiceAgent.AGENT_CODE);

        // 3. 读取短期记忆（不含刚写入的本轮消息，history 需截掉末尾一条防重复）
        List<Map<String, String>> history = chatMemoryService.history(session.getSessionId());
        if (!history.isEmpty()) {
            history = history.subList(0, history.size() - 1);
        }

        // 4. 流式生成（Reactor 订阅在独立线程，SseEmitter 主线程立即返回）
        //    收尾统一在 doFinally：正常完成 / stop 的 dispose(cancel) / 异常，三路都会经过
        chatStopRegistry.register(assistantMessageId);
        StringBuilder fullText = new StringBuilder();
        AtomicBoolean settled = new AtomicBoolean(false);
        AtomicBoolean failed = new AtomicBoolean(false);
        String sessionId = session.getSessionId();
        Disposable disposable = customerServiceAgent.stream(message, history)
                .doOnNext(delta -> {
                    if (!sender.isBroken()) {
                        fullText.append(delta);
                        sender.textDelta(delta);
                    }
                })
                .doOnError(error -> {
                    failed.set(true);
                    log.error("流式生成异常 messageId={}", assistantMessageId, error);
                })
                .doFinally(signal -> {
                    if (!settled.compareAndSet(false, true)) {
                        return;
                    }
                    try {
                        if (failed.get()) {
                            aiSessionService.completeAssistantMessage(assistantMessageId,
                                    "FAILED", fullText.toString(), null, null);
                            sender.error("llm_error", "生成失败，请稍后重试");
                        } else {
                            // cancel 信号 = stop 掐断（dispose），complete = 自然结束
                            boolean stopped = signal == SignalType.CANCEL
                                    || chatStopRegistry.isStopRequested(assistantMessageId);
                            aiSessionService.completeAssistantMessage(assistantMessageId,
                                    stopped ? "STOPPED" : "COMPLETED", fullText.toString(), null, null);
                            if (fullText.length() > 0) {
                                chatMemoryService.append(sessionId, "assistant", fullText.toString());
                            }
                            sender.finish(assistantMessageId);
                        }
                    } finally {
                        chatStopRegistry.unregister(assistantMessageId);
                    }
                })
                .subscribe(delta -> { }, error -> { });

        // stop 接口通过注册表 dispose 上游流（立即停止 token 消耗）；断连/超时同样掐断
        chatStopRegistry.bindUpstream(assistantMessageId, disposable);
        emitter.onTimeout(disposable::dispose);
        emitter.onError(t -> disposable.dispose());
        return emitter;
    }

    /**
     * 停止生成（body: {messageId}）：置停止标记，生成循环感知后以 STOPPED 收尾
     */
    @PostMapping("/stop")
    public Result<Boolean> stop(@RequestBody Map<String, String> body) {
        String messageId = body.get("messageId");
        boolean accepted = StringUtils.hasText(messageId) && chatStopRegistry.requestStop(messageId);
        return Result.success(accepted);
    }
}
