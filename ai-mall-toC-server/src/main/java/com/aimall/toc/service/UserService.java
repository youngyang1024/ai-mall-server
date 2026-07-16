package com.aimall.toc.service;

import com.aimall.toc.dto.PasswordUpdateDTO;
import com.aimall.toc.dto.UserUpdateDTO;
import com.aimall.toc.vo.UserInfoVO;

/**
 * C端用户信息服务接口：查询个人信息/修改个人资料/修改密码
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface UserService {
    UserInfoVO getInfo(Long userId);
    void updateInfo(Long userId, UserUpdateDTO dto);
    void updatePassword(Long userId, PasswordUpdateDTO dto);
}
