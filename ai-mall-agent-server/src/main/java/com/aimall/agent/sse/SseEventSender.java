package com.aimall.agent.sse;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * SSE 事件发射封装：统一事件协议的序列化与发送
 *
 * <p>事件协议（data 为 JSON，流末尾发送 [DONE]）：
 * <p>1. start: {type, sessionId, messageId} 流开始，携带会话与本条 assistant 消息ID
 * <p>2. agent: {type, name} 路由结果（前端展示 "XX助手为您服务"）
 * <p>3. text-delta: {type, delta} 文字增量
 * <p>4. card: {type, cardType, data} 结构化卡片（product_list/ticket_confirm）
 * <p>5. suggest: {type, questions} 快捷追问
 * <p>6. finish: {type, messageId} 正常结束
 * <p>7. error: {type, code, message} 异常（quota_exceeded/llm_error 等）
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
public class SseEventSender {

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    private final SseEmitter emitter;

    /** 发送是否已失败（客户端断连后不再尝试） */
    private volatile boolean broken = false;

    public SseEventSender(SseEmitter emitter) {
        this.emitter = emitter;
    }

    public void start(String sessionId, String messageId) {
        send(event("start", "sessionId", sessionId, "messageId", messageId));
    }

    public void agent(String agentCode) {
        send(event("agent", "name", agentCode));
    }

    public void textDelta(String delta) {
        send(event("text-delta", "delta", delta));
    }

    public void card(String cardType, Object data) {
        Map<String, Object> payload = event("card", "cardType", cardType);
        payload.put("data", data);
        send(payload);
    }

    public void suggest(Object questions) {
        send(event("suggest", "questions", questions));
    }

    public void finish(String messageId) {
        send(event("finish", "messageId", messageId));
        sendRaw("[DONE]");
        emitter.complete();
    }

    public void error(String code, String message) {
        send(event("error", "code", code, "message", message));
        sendRaw("[DONE]");
        emitter.complete();
    }

    public boolean isBroken() {
        return broken;
    }

    private Map<String, Object> event(String type, Object... kvs) {
        Map<String, Object> map = new LinkedHashMap<>();
        map.put("type", type);
        for (int i = 0; i + 1 < kvs.length; i += 2) {
            map.put(String.valueOf(kvs[i]), kvs[i + 1]);
        }
        return map;
    }

    private void send(Map<String, Object> payload) {
        try {
            sendRaw(OBJECT_MAPPER.writeValueAsString(payload));
        } catch (IOException e) {
            log.warn("SSE 事件序列化失败: {}", e.getMessage());
        }
    }

    private void sendRaw(String data) {
        if (broken) {
            return;
        }
        try {
            emitter.send(SseEmitter.event().data(data));
        } catch (Exception e) {
            // 客户端断连（刷新/关闭页面）属正常情况，标记后停止发送
            broken = true;
            log.info("SSE 客户端断连，停止推送");
        }
    }
}
