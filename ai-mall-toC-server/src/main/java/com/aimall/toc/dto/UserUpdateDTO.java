package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 用户信息更新请求 DTO：昵称、手机号及头像
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("用户信息更新")
public class UserUpdateDTO {
    private String nickname;
    private String phone;
    private String avatar;
}
