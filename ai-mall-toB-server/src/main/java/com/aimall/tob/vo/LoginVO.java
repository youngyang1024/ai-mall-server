package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 登录响应
 */
@Data
@ApiModel("登录响应")
public class LoginVO {

    @ApiModelProperty("JWT Token")
    private String token;

    @ApiModelProperty("管理员ID")
    private Long adminId;

    @ApiModelProperty("用户名")
    private String username;

    @ApiModelProperty("昵称")
    private String nickname;
}
