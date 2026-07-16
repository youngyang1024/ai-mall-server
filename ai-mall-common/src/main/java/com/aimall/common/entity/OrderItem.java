package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 订单明细实体，对应表 t_order_item，记录订单中每个 SKU 的商品快照（名称、规格、图片、单价、数量）
 *
 * @author
 * Created by Yang on 2026/07/16
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
