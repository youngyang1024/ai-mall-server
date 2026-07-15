package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 购物车
 */
@Data
public class Cart {

    private Long id;
    private Long userId;
    private Long skuId;
    private Integer quantity;
    private Integer checked;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
