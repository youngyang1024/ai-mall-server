package com.aimall.agent.interceptor;

import com.aimall.agent.common.Result;
import com.aimall.agent.context.ChatPrincipalContext;
import com.aimall.agent.util.JwtUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.AsyncHandlerInterceptor;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * 会话身份拦截器：登录用户与游客双身份解析（对齐 V1 UserAuthInterceptor 的校验逻辑，但游客不拒绝）
 *
 * <p>1. 携带有效 Bearer Token（C 端、未过期、与 Redis 中 token:c:{userId} 一致）则解析为登录身份
 * <p>2. 无 Token 或 Token 无效时，从 X-Guest-Eid 请求头读取游客标识降级为游客身份；两者都没有才拒绝
 * <p>3. 身份写入 ChatPrincipalContext（ThreadLocal）；实现 AsyncHandlerInterceptor 以适配 SSE 异步请求——
 *    异步启动时（afterConcurrentHandlingStarted）即在原始请求线程上清理，防止 Tomcat 线程复用串上下文
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class ChatAuthInterceptor implements AsyncHandlerInterceptor {

    /** 与 V1 RedisKeyConstant 对齐的 Token key 前缀与 C 端用户类型 */
    private static final String TOKEN_PREFIX = "token:";
    private static final String USER_TYPE_C = "c";

    /** 游客标识请求头（前端 localStorage 生成的 UUID） */
    private static final String HEADER_GUEST_EID = "X-Guest-Eid";

    private final JwtUtil jwtUtil;
    private final StringRedisTemplate stringRedisTemplate;
    private final ObjectMapper objectMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        ChatPrincipalContext.ChatPrincipal principal = resolveLoginPrincipal(request);
        if (principal == null) {
            principal = resolveGuestPrincipal(request);
        }
        if (principal == null) {
            writeUnauthorized(response);
            return false;
        }
        ChatPrincipalContext.set(principal);
        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        ChatPrincipalContext.clear();
    }

    @Override
    public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) {
        // SSE 返回 SseEmitter 进入异步模式：afterCompletion 会在异步完成后的另一线程执行，
        // 原始请求线程的 ThreadLocal 必须在此处（仍在原线程上）清理
        ChatPrincipalContext.clear();
    }

    /**
     * 解析登录身份：校验失败返回 null（不抛错，降级游客）
     */
    private ChatPrincipalContext.ChatPrincipal resolveLoginPrincipal(HttpServletRequest request) {
        String bearer = request.getHeader("Authorization");
        if (!StringUtils.hasText(bearer) || !bearer.startsWith("Bearer ")) {
            return null;
        }
        String token = bearer.substring(7);
        try {
            Claims claims = jwtUtil.parseToken(token);
            if (jwtUtil.isExpired(claims) || !USER_TYPE_C.equals(jwtUtil.getUserType(claims))) {
                return null;
            }
            Long userId = jwtUtil.getUserId(claims);
            String tokenKey = TOKEN_PREFIX + USER_TYPE_C + ":" + userId;
            if (!token.equals(stringRedisTemplate.opsForValue().get(tokenKey))) {
                return null;
            }
            return new ChatPrincipalContext.ChatPrincipal(userId, null, jwtUtil.getUsername(claims));
        } catch (Exception e) {
            log.warn("Token 解析失败，降级游客身份: {}", e.getMessage());
            return null;
        }
    }

    private ChatPrincipalContext.ChatPrincipal resolveGuestPrincipal(HttpServletRequest request) {
        String eid = request.getHeader(HEADER_GUEST_EID);
        if (!StringUtils.hasText(eid) || eid.length() > 64) {
            return null;
        }
        return new ChatPrincipalContext.ChatPrincipal(null, eid, null);
    }

    private void writeUnauthorized(HttpServletResponse response) throws IOException {
        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.getWriter().write(objectMapper.writeValueAsString(
                Result.fail(Result.CODE_UNAUTHORIZED, "缺少登录态或游客标识")));
    }
}
