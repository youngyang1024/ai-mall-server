package com.aimall.tob.service;

import com.aimall.tob.dto.LoginDTO;
import com.aimall.tob.vo.LoginVO;

/**
 * B端管理员认证服务接口：定义管理员登录、登出能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface AdminAuthService {

    LoginVO login(LoginDTO loginDTO);

    void logout(Long adminId);
}
