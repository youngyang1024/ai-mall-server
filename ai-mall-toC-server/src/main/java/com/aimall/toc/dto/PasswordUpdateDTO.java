package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 修改密码请求 DTO：原密码及新密码
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("修改密码请求")
public class PasswordUpdateDTO {
    @NotBlank(message = "原密码不能为空")
    private String oldPassword;
    @NotBlank(message = "新密码不能为空")
    private String newPassword;
}
