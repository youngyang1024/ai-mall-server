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
 * B端 JWT 认证拦截器：拦截 /admin/** 请求（登录、健康检查等白名单除外），校验管理员登录态并维护 UserContext
 * <p>1. 从请求头 Authorization 中解析 Bearer token，token 缺失时返回未登录响应并拒绝放行
 * <p>2. 使用 JwtUtil 解析 token 得到 Claims，校验是否过期，并校验用户类型必须为 B端（USER_TYPE_B），否则返回无权限
 * <p>3. 从 Claims 中取出管理员 id，读取 Redis 中缓存的登录态 token 与请求 token 比对，不一致（已登出或已被新登录顶掉）则按未登录拒绝
 * <p>4. 校验通过后将管理员 id、用户名、用户类型写入 UserContext 并放行；解析过程中任一异常均按未登录处理，afterCompletion 中清理 UserContext 防止线程复用泄漏
 *
 * @author
 * Created by Yang on 2026/07/16
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
