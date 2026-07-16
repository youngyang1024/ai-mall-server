package com.aimall.tob.service.impl;

import com.aimall.common.constant.RedisKeyConstant;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.result.ResultCode;
import com.aimall.common.util.JwtUtil;
import com.aimall.common.util.RedisUtil;
import com.aimall.tob.dto.LoginDTO;
import com.aimall.tob.entity.Admin;
import com.aimall.tob.mapper.AdminMapper;
import com.aimall.tob.service.AdminAuthService;
import com.aimall.tob.vo.LoginVO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * 管理员认证服务实现，基于 JWT + Redis 维护 B 端登录态
 * <p>1. 登录校验：按用户名查询管理员，校验账号未禁用且 BCrypt 密码匹配；用户不存在与密码错误统一提示"用户名或密码错误"
 * <p>2. 签发 token：通过 JwtUtil 生成携带管理员 id、B 端用户类型、用户名的 JWT token，并以 RedisKeyConstant.tokenKey 为 key 写入 Redis，过期时间取 jwt.expiration 配置（毫秒）
 * <p>3. 登出：删除 Redis 中该管理员的 tokenKey，使 token 立即失效（服务端登录态以 Redis 中的 token 为准）
 * <p>4. 依赖 AdminMapper、JwtUtil、RedisUtil、BCryptPasswordEncoder
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class AdminAuthServiceImpl implements AdminAuthService {

    private final AdminMapper adminMapper;
    private final JwtUtil jwtUtil;
    private final RedisUtil redisUtil;
    private final BCryptPasswordEncoder passwordEncoder;

    @Value("${jwt.expiration}")
    private Long jwtExpiration;

    public AdminAuthServiceImpl(AdminMapper adminMapper, JwtUtil jwtUtil,
                                RedisUtil redisUtil, BCryptPasswordEncoder passwordEncoder) {
        this.adminMapper = adminMapper;
        this.jwtUtil = jwtUtil;
        this.redisUtil = redisUtil;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * 管理员登录
     *
     * 流程说明：
     * 1. 根据用户名查询管理员
     * 2. 校验账号状态与密码
     * 3. 生成 JWT Token（有效期 7 天）
     * 4. 将 Token 缓存到 Redis，支持登出失效
     */
    @Override
    public LoginVO login(LoginDTO loginDTO) {
        Admin admin = adminMapper.selectByUsername(loginDTO.getUsername());
        if (admin == null) {
            throw new BusinessException(ResultCode.UNAUTHORIZED.getCode(), "用户名或密码错误");
        }
        if (admin.getStatus() != null && admin.getStatus() == 0) {
            throw new BusinessException("账号已被禁用");
        }
        if (!passwordEncoder.matches(loginDTO.getPassword(), admin.getPassword())) {
            throw new BusinessException(ResultCode.UNAUTHORIZED.getCode(), "用户名或密码错误");
        }

        String token = jwtUtil.generateToken(admin.getId(), RedisKeyConstant.USER_TYPE_B, admin.getUsername());
        String tokenKey = RedisKeyConstant.tokenKey(RedisKeyConstant.USER_TYPE_B, admin.getId());
        redisUtil.set(tokenKey, token, jwtExpiration, TimeUnit.MILLISECONDS);

        LoginVO vo = new LoginVO();
        vo.setToken(token);
        vo.setAdminId(admin.getId());
        vo.setUsername(admin.getUsername());
        vo.setNickname(admin.getNickname());
        return vo;
    }

    @Override
    public void logout(Long adminId) {
        String tokenKey = RedisKeyConstant.tokenKey(RedisKeyConstant.USER_TYPE_B, adminId);
        redisUtil.delete(tokenKey);
    }
}
