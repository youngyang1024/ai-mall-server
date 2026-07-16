package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 优惠券模板实体，对应表 t_coupon，定义优惠券的类型、使用门槛、优惠金额、发放总量及有效期
 *
 * @author
 * Created by Yang on 2026/07/16
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
