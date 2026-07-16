package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 登录响应对象：承载JWT Token、管理员ID、用户名、昵称，用于商家后台登录成功后的凭证与身份信息返回
 *
 * @author
 * Created by Yang on 2026/07/16
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
