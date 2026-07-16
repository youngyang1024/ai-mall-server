package com.aimall.tob.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 管理员实体：对应 B端管理员表，包含账号、密码、昵称、状态及创建/更新时间字段
 *
 * @author
 * Created by Yang on 2026/07/16
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
