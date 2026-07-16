package com.aimall.toc.service.impl;

import com.aimall.common.constant.RedisKeyConstant;
import com.aimall.common.entity.User;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.result.ResultCode;
import com.aimall.common.util.JwtUtil;
import com.aimall.common.util.RedisUtil;
import com.aimall.toc.dto.LoginDTO;
import com.aimall.toc.dto.RegisterDTO;
import com.aimall.toc.mapper.UserMapper;
import com.aimall.toc.service.AuthService;
import com.aimall.toc.vo.LoginVO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

/**
 * C端用户认证服务，负责注册、登录与登出
 *
 * <p>1. 注册：校验用户名唯一，密码经 BCrypt 加密后落库，注册即生效（无需邮箱验证），昵称缺省取用户名
 * <p>2. 登录：BCrypt 校验密码，拦截禁用账号（status 为 0 拒绝登录），签发携带用户 ID/用户类型/用户名的 JWT，并以 C端用户维度写入 Redis（TTL 与 JWT 过期时间一致），实现单端有效与服务端可控失效
 * <p>3. 登出：删除 Redis 中该用户的 Token 记录，使 Token 立即失效
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class AuthServiceImpl implements AuthService {

    private final UserMapper userMapper;
    private final JwtUtil jwtUtil;
    private final RedisUtil redisUtil;
    private final BCryptPasswordEncoder passwordEncoder;

    @Value("${jwt.expiration}")
    private Long jwtExpiration;

    public AuthServiceImpl(UserMapper userMapper, JwtUtil jwtUtil, RedisUtil redisUtil,
                           BCryptPasswordEncoder passwordEncoder) {
        this.userMapper = userMapper;
        this.jwtUtil = jwtUtil;
        this.redisUtil = redisUtil;
        this.passwordEncoder = passwordEncoder;
    }

    /**
     * 用户注册
     *
     * 流程说明：
     * 1. 校验用户名是否已存在
     * 2. 密码 BCrypt 加密
     * 3. 创建用户记录（无需邮箱验证，注册即生效）
     */
    @Override
    public void register(RegisterDTO dto) {
        if (userMapper.selectByUsername(dto.getUsername()) != null) {
            throw new BusinessException("用户名已存在");
        }
        User user = new User();
        user.setUsername(dto.getUsername());
        user.setPassword(passwordEncoder.encode(dto.getPassword()));
        user.setNickname(dto.getNickname() != null ? dto.getNickname() : dto.getUsername());
        user.setPhone(dto.getPhone());
        user.setStatus(1);
        userMapper.insert(user);
    }

    @Override
    public LoginVO login(LoginDTO dto) {
        User user = userMapper.selectByUsername(dto.getUsername());
        if (user == null || !passwordEncoder.matches(dto.getPassword(), user.getPassword())) {
            throw new BusinessException(ResultCode.UNAUTHORIZED.getCode(), "用户名或密码错误");
        }
        if (user.getStatus() != null && user.getStatus() == 0) {
            throw new BusinessException("账号已被禁用");
        }
        String token = jwtUtil.generateToken(user.getId(), RedisKeyConstant.USER_TYPE_C, user.getUsername());
        String tokenKey = RedisKeyConstant.tokenKey(RedisKeyConstant.USER_TYPE_C, user.getId());
        redisUtil.set(tokenKey, token, jwtExpiration, TimeUnit.MILLISECONDS);

        LoginVO vo = new LoginVO();
        vo.setToken(token);
        vo.setUserId(user.getId());
        vo.setUsername(user.getUsername());
        vo.setNickname(user.getNickname());
        return vo;
    }

    @Override
    public void logout(Long userId) {
        redisUtil.delete(RedisKeyConstant.tokenKey(RedisKeyConstant.USER_TYPE_C, userId));
    }
}
