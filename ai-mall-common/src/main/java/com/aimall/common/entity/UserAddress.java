package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 收货地址实体，对应表 t_user_address，记录用户的收件人信息与省市区详细地址，isDefault 标识默认地址
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class UserAddress {

    private Long id;
    private Long userId;
    private String receiverName;
    private String receiverPhone;
    private String province;
    private String city;
    private String district;
    private String detail;
    private Integer isDefault;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
