package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 订单明细
 */
@Data
public class OrderItem {

    private Long id;
    private Long orderId;
    private Long spuId;
    private Long skuId;
    private String spuName;
    private String skuSpec;
    private String image;
    private BigDecimal price;
    private Integer quantity;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
