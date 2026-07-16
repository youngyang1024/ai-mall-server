package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * C端用户实体，对应表 t_user，记录商城注册用户的账号、密码、昵称、手机号、头像及启用状态
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class User {

    private Long id;
    private String username;
    private String password;
    private String nickname;
    private String phone;
    private String avatar;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
