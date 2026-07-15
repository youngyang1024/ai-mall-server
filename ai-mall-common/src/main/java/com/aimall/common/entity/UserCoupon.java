package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户优惠券
 */
@Data
public class UserCoupon {

    private Long id;
    private Long userId;
    private Long couponId;
    private Integer status;
    private LocalDateTime receiveTime;
    private LocalDateTime useTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
