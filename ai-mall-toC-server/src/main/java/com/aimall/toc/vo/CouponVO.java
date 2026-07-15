package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@ApiModel("可领取优惠券")
public class CouponVO {

    private Long id;
    private String name;
    private BigDecimal threshold;
    private BigDecimal discount;
    private Integer totalCount;
    private Integer receivedCount;
    private Integer remainCount;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Boolean received;
}
