package com.aimall.tob.service;

import com.aimall.tob.dto.LoginDTO;
import com.aimall.tob.vo.LoginVO;

/**
 * 管理员认证服务
 */
public interface AdminAuthService {

    LoginVO login(LoginDTO loginDTO);

    void logout(Long adminId);
}
