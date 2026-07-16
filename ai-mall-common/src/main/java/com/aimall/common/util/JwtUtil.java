package com.aimall.common.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * JWT 工具类，负责登录 Token 的生成与解析，密钥和过期时间通过 jwt.secret、jwt.expiration 配置注入
 * <p>1. 生成：以 userId 为 subject，将 userId、userType（c/b）、username 写入 claims，使用 HS256 算法签名
 * <p>2. 解析：校验签名并返回 Claims，供拦截器提取用户信息写入 UserContext
 * <p>3. 提供从 Claims 中获取 userId、userType、username 及判断 Token 是否过期的便捷方法
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Component
public class JwtUtil {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.expiration}")
    private Long expiration;

    /**
     * 生成 Token
     *
     * @param userId   用户ID
     * @param userType 用户类型（c/b）
     * @param username 用户名
     */
    public String generateToken(Long userId, String userType, String username) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("userId", userId);
        claims.put("userType", userType);
        claims.put("username", username);
        Date now = new Date();
        Date expiry = new Date(now.getTime() + expiration);
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(String.valueOf(userId))
                .setIssuedAt(now)
                .setExpiration(expiry)
                .signWith(SignatureAlgorithm.HS256, secret)
                .compact();
    }

    public Claims parseToken(String token) {
        return Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token)
                .getBody();
    }

    public Long getUserId(Claims claims) {
        return Long.valueOf(claims.get("userId").toString());
    }

    public String getUserType(Claims claims) {
        return claims.get("userType").toString();
    }

    public String getUsername(Claims claims) {
        return claims.get("username").toString();
    }

    public boolean isExpired(Claims claims) {
        return claims.getExpiration().before(new Date());
    }
}
