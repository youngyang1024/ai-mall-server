package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

@Data
@ApiModel("用户信息")
public class UserInfoVO {
    private Long id;
    private String username;
    private String nickname;
    private String phone;
    private String avatar;
}
