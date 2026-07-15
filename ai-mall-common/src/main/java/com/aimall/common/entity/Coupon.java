package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 优惠券模板
 */
@Data
public class Coupon {

    private Long id;
    private String name;
    private Integer type;
    private BigDecimal threshold;
    private BigDecimal discount;
    private Integer totalCount;
    private Integer receivedCount;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
