package com.aimall.toc.interceptor;

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
 * C端 JWT 认证拦截器
 */
@Component
public class UserAuthInterceptor implements HandlerInterceptor {

    private final JwtUtil jwtUtil;
    private final RedisUtil redisUtil;
    private final ObjectMapper objectMapper;

    public UserAuthInterceptor(JwtUtil jwtUtil, RedisUtil redisUtil, ObjectMapper objectMapper) {
        this.jwtUtil = jwtUtil;
        this.redisUtil = redisUtil;
        this.objectMapper = objectMapper;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String token = resolveToken(request);
        if (!StringUtils.hasText(token)) {
            writeUnauthorized(response);
            return false;
        }
        try {
            Claims claims = jwtUtil.parseToken(token);
            if (jwtUtil.isExpired(claims)) {
                writeUnauthorized(response);
                return false;
            }
            if (!RedisKeyConstant.USER_TYPE_C.equals(jwtUtil.getUserType(claims))) {
                writeUnauthorized(response);
                return false;
            }
            Long userId = jwtUtil.getUserId(claims);
            String tokenKey = RedisKeyConstant.tokenKey(RedisKeyConstant.USER_TYPE_C, userId);
            if (!token.equals(redisUtil.get(tokenKey))) {
                writeUnauthorized(response);
                return false;
            }
            UserContext.set(userId, jwtUtil.getUsername(claims), RedisKeyConstant.USER_TYPE_C);
            return true;
        } catch (Exception e) {
            writeUnauthorized(response);
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

    private void writeUnauthorized(HttpServletResponse response) throws IOException {
        response.setStatus(HttpServletResponse.SC_OK);
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding(StandardCharsets.UTF_8.name());
        response.getWriter().write(objectMapper.writeValueAsString(
                Result.fail(ResultCode.UNAUTHORIZED.getCode(), "未登录或Token已过期")));
    }
}
