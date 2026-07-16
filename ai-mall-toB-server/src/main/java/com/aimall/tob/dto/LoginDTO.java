package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 管理员登录请求参数：承载用户名、密码字段，用于商家后台登录认证
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("管理员登录请求")
public class LoginDTO {

    @NotBlank(message = "用户名不能为空")
    @ApiModelProperty(value = "用户名", required = true)
    private String username;

    @NotBlank(message = "密码不能为空")
    @ApiModelProperty(value = "密码", required = true)
    private String password;
}
