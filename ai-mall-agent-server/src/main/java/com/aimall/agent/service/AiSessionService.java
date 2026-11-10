package com.aimall.agent.service;

import com.aimall.agent.context.ChatPrincipalContext;
import com.aimall.agent.entity.AiMessage;
import com.aimall.agent.entity.AiSession;
import com.aimall.agent.mapper.AiMessageMapper;
import com.aimall.agent.mapper.AiSessionMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

/**
 * AI 会话服务：会话生命周期与消息落库
 *
 * <p>1. 会话创建/续用：无 sessionId 新建（标题取首条消息截断）；有则校验归属后续用并刷新活跃时间
 * <p>2. 消息落库：用户消息即写 COMPLETED；assistant 消息先占位 GENERATING，流结束回填内容与状态
 * <p>3. 归属校验：会话必须属于当前身份（登录比 userId，游客比 eid），防串会话
 * <p>4. 游客登录绑定：将 eid 名下会话与消息一次性迁移到 userId
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AiSessionService {

    /** 会话标题最大长度（超出截断） */
    private static final int TITLE_MAX_LENGTH = 50;

    private final AiSessionMapper aiSessionMapper;
    private final AiMessageMapper aiMessageMapper;

    /**
     * 获取或创建会话：sessionId 为空则新建；非空则校验归属后返回
     *
     * @throws IllegalArgumentException 会话不存在或不属于当前身份
     */
    public AiSession getOrCreateSession(String sessionId, String firstMessage) {
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        if (!StringUtils.hasText(sessionId)) {
            AiSession session = new AiSession();
            session.setSessionId(UUID.randomUUID().toString());
            session.setUserId(principal.getUserId());
            session.setEid(principal.getEid());
            session.setTitle(truncateTitle(firstMessage));
            session.setStatus("ACTIVE");
            session.setLastActiveTime(LocalDateTime.now());
            aiSessionMapper.insert(session);
            return session;
        }
        AiSession session = aiSessionMapper.selectBySessionId(sessionId);
        if (session == null || !belongsToCurrent(session, principal)) {
            throw new IllegalArgumentException("会话不存在或无权访问");
        }
        aiSessionMapper.updateLastActiveTime(sessionId);
        return session;
    }

    /**
     * 保存用户消息（COMPLETED），返回消息ID
     */
    public String saveUserMessage(String sessionId, String content) {
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        AiMessage message = new AiMessage();
        message.setMessageId(UUID.randomUUID().toString());
        message.setSessionId(sessionId);
        message.setUserId(principal.getUserId());
        message.setEid(principal.getEid());
        message.setRole("user");
        message.setStatus("COMPLETED");
        message.setContent(content);
        message.setCompletedTime(LocalDateTime.now());
        aiMessageMapper.insert(message);
        return message.getMessageId();
    }

    /**
     * 占位 assistant 消息（GENERATING），流结束后调 completeAssistantMessage 回填
     */
    public String saveAssistantPlaceholder(String sessionId, String requestMessageId, String agentCode) {
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        AiMessage message = new AiMessage();
        message.setMessageId(UUID.randomUUID().toString());
        message.setRequestMessageId(requestMessageId);
        message.setSessionId(sessionId);
        message.setUserId(principal.getUserId());
        message.setEid(principal.getEid());
        message.setRole("assistant");
        message.setAgentCode(agentCode);
        message.setStatus("GENERATING");
        aiMessageMapper.insert(message);
        return message.getMessageId();
    }

    /**
     * 回填 assistant 消息（COMPLETED/STOPPED/FAILED）
     */
    public void completeAssistantMessage(String messageId, String status, String content,
                                         String cardsJson, Integer tokenUsage) {
        aiMessageMapper.updateCompletion(messageId, status, content, cardsJson, tokenUsage);
    }

    /**
     * 当前身份的会话列表
     */
    public List<AiSession> listSessions() {
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        return principal.isLogin()
                ? aiSessionMapper.selectByUserId(principal.getUserId())
                : aiSessionMapper.selectByEid(principal.getEid());
    }

    /**
     * 会话历史消息（校验归属，时间正序分页）
     */
    public List<AiMessage> listMessages(String sessionId, int page, int size) {
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        AiSession session = aiSessionMapper.selectBySessionId(sessionId);
        if (session == null || !belongsToCurrent(session, principal)) {
            throw new IllegalArgumentException("会话不存在或无权访问");
        }
        int offset = Math.max(0, (page - 1) * size);
        return aiMessageMapper.selectBySessionId(sessionId, offset, size);
    }

    /**
     * 游客登录后绑定：eid 名下会话与消息迁移到当前登录用户
     */
    @Transactional(rollbackFor = Exception.class)
    public void bindGuestSessions(String eid) {
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        if (!principal.isLogin() || !StringUtils.hasText(eid)) {
            return;
        }
        int sessions = aiSessionMapper.bindUserByEid(eid, principal.getUserId());
        int messages = aiMessageMapper.bindUserByEid(eid, principal.getUserId());
        log.info("游客会话绑定完成 eid={} userId={} sessions={} messages={}",
                eid, principal.getUserId(), sessions, messages);
    }

    private boolean belongsToCurrent(AiSession session, ChatPrincipalContext.ChatPrincipal principal) {
        if (principal.isLogin()) {
            return principal.getUserId().equals(session.getUserId());
        }
        // 游客只能访问未绑定用户的本 eid 会话
        return session.getUserId() == null && principal.getEid().equals(session.getEid());
    }

    private String truncateTitle(String firstMessage) {
        if (!StringUtils.hasText(firstMessage)) {
            return "新会话";
        }
        return firstMessage.length() > TITLE_MAX_LENGTH
                ? firstMessage.substring(0, TITLE_MAX_LENGTH)
                : firstMessage;
    }
}
