package com.aimall.agent.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * JWT 解析工具，与 V1 共用同一 jwt.secret（jjwt 0.9.1 同版本保证解析行为一致）
 *
 * <p>1. 仅解析不生成：agent-server 不负责登录，只识别 V1 toC 签发的 C 端 Token
 * <p>2. 提供 userId/userType/username 提取与过期判断，供认证拦截器使用
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Component
public class JwtUtil {

    @Value("${jwt.secret}")
    private String secret;

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
