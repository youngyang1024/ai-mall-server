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
