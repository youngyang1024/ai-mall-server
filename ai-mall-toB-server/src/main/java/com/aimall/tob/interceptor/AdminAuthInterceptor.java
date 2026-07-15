package com.aimall.tob.interceptor;

import com.aimall.common.constant.RedisKeyConstant;
import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.common.result.ResultCode;
import com.aimall.common.util.JwtUtil;
import com.aimall.common.util.RedisUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.jsonwebtoken.Claims;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;

/**
 * B端 JWT 认证拦截器
 */
@Component
public class AdminAuthInterceptor implements HandlerInterceptor {

    private final JwtUtil jwtUtil;
    private final RedisUtil redisUtil;
    private final ObjectMapper objectMapper;

    public AdminAuthInterceptor(JwtUtil jwtUtil, RedisUtil redisUtil, ObjectMapper objectMapper) {
        this.jwtUtil = jwtUtil;
        this.redisUtil = redisUtil;
        this.objectMapper = objectMapper;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = resolveToken(request);
        if (!StringUtils.hasText(token)) {
            writeUnauthorized(response, "未登录或Token已过期");
            return false;
        }
        try {
            Claims claims = jwtUtil.parseToken(token);
            if (jwtUtil.isExpired(claims)) {
                writeUnauthorized(response, "未登录或Token已过期");
                return false;
            }
            if (!RedisKeyConstant.USER_TYPE_B.equals(jwtUtil.getUserType(claims))) {
                writeUnauthorized(response, "无权限");
                return false;
            }
            Long adminId = jwtUtil.getUserId(claims);
            String tokenKey = RedisKeyConstant.tokenKey(RedisKeyConstant.USER_TYPE_B, adminId);
            String cachedToken = redisUtil.get(tokenKey);
            if (!token.equals(cachedToken)) {
                writeUnauthorized(response, "未登录或Token已过期");
                return false;
            }
            UserContext.set(adminId, jwtUtil.getUsername(claims), RedisKeyConstant.USER_TYPE_B);
            return true;
        } catch (Exception e) {
            writeUnauthorized(response, "未登录或Token已过期");
            return false;
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        UserContext.clear();
    }

    private String resolveToken(HttpServletRequest request) {
        String bearer = request.getHeader("Authorization");
        if (StringUtils.hasText(bearer) && bearer.startsWith("Bearer ")) {
            return bearer.substring(7);
        }
        return null;
    }

    private void writeUnauthorized(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.getWriter().write(objectMapper.writeValueAsString(Result.fail(ResultCode.UNAUTHORIZED.getCode(), message)));
    }
}
