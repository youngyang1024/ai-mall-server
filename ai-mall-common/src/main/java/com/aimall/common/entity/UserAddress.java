package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 收货地址
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
