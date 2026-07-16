package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 用户登录请求 DTO：用户名及密码
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("用户登录请求")
public class LoginDTO {
    @NotBlank(message = "用户名不能为空")
    private String username;
    @NotBlank(message = "密码不能为空")
    private String password;
}
