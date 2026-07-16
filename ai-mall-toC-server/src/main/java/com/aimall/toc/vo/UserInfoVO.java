package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 * 用户信息返回 VO：用户名、昵称、手机号及头像
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("用户信息")
public class UserInfoVO {
    private Long id;
    private String username;
    private String nickname;
    private String phone;
    private String avatar;
}
