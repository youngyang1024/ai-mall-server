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
 * C端 JWT 认证拦截器，对需要登录的接口做 Token 校验与用户上下文传递
 *
 * <p>1. 从 Authorization 请求头解析 Bearer Token，解析 JWT 并校验未过期、用户类型为 C端
 * <p>2. 与 Redis 中该用户当前有效 Token 比对，不一致即拒绝（登出或 Redis Token 被删除即失效，实现单端登录与服务端可控失效），任一环节校验失败统一返回未登录错误响应
 * <p>3. 校验通过后将用户 ID/用户名/用户类型写入 UserContext（ThreadLocal）供下游业务读取，请求完成后在 afterCompletion 中清理，防止线程复用导致的上下文串用
 *
 * @author
 * Created by Yang on 2026/07/16
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
