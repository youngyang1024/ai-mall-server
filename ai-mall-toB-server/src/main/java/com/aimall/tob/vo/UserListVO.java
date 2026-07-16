package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户列表展示对象（不含密码）：承载用户ID、用户名、昵称、手机号、头像、状态、创建/更新时间，用于商家后台用户列表展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("用户列表项")
public class UserListVO {

    private Long id;
    private String username;
    private String nickname;
    private String phone;
    private String avatar;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
