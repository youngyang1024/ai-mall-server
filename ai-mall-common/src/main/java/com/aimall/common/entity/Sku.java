package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 商品 SKU
 */
@Data
public class Sku {

    private Long id;
    private Long spuId;
    private String specJson;
    private BigDecimal price;
    private Integer stock;
    private String image;
    private String skuCode;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
