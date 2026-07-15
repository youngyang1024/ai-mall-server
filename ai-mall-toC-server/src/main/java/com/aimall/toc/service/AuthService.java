package com.aimall.toc.service;

import com.aimall.toc.dto.LoginDTO;
import com.aimall.toc.dto.RegisterDTO;
import com.aimall.toc.vo.LoginVO;

public interface AuthService {
    void register(RegisterDTO dto);
    LoginVO login(LoginDTO dto);
    void logout(Long userId);
}
