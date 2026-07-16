package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 用户优惠券返回 VO：券信息、门槛、优惠金额、使用状态、有效期及领取/使用时间
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("用户优惠券")
public class UserCouponVO {

    private Long id;
    private Long couponId;
    private String couponName;
    private BigDecimal threshold;
    private BigDecimal discount;
    private Integer status;
    private String statusDesc;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private LocalDateTime receiveTime;
    private LocalDateTime useTime;
    private Boolean received;
}
