package com.aimall.toc.service;

import com.aimall.toc.dto.PasswordUpdateDTO;
import com.aimall.toc.dto.UserUpdateDTO;
import com.aimall.toc.vo.UserInfoVO;

public interface UserService {
    UserInfoVO getInfo(Long userId);
    void updateInfo(Long userId, UserUpdateDTO dto);
    void updatePassword(Long userId, PasswordUpdateDTO dto);
}
