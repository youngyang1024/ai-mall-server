package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 * 用户登录返回 VO：登录 token 及用户基本信息
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("登录响应")
public class LoginVO {
    private String token;
    private Long userId;
    private String username;
    private String nickname;
}
