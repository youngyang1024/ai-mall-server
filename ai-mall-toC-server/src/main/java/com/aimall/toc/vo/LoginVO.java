package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

@Data
@ApiModel("登录响应")
public class LoginVO {
    private String token;
    private Long userId;
    private String username;
    private String nickname;
}
