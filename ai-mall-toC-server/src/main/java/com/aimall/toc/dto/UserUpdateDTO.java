package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
@ApiModel("用户信息更新")
public class UserUpdateDTO {
    private String nickname;
    private String phone;
    private String avatar;
}
