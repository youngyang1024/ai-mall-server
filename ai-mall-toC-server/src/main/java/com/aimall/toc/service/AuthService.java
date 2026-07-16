package com.aimall.toc.service;

import com.aimall.toc.dto.LoginDTO;
import com.aimall.toc.dto.RegisterDTO;
import com.aimall.toc.vo.LoginVO;

/**
 * C端用户认证服务接口：注册/登录/登出
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface AuthService {
    void register(RegisterDTO dto);
    LoginVO login(LoginDTO dto);
    void logout(Long userId);
}
