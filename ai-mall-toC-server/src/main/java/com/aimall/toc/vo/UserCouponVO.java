package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

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
