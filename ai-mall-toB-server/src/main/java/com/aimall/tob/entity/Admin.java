package com.aimall.tob.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 管理员实体
 */
@Data
public class Admin {

    private Long id;
    private String username;
    private String password;
    private String nickname;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
