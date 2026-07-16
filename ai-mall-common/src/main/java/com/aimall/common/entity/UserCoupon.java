package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 用户优惠券实体，对应表 t_user_coupon，记录用户领取的优惠券及其使用状态、领取和使用时间
 *
 * @author
 * Created by Yang on 2026/07/16
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
