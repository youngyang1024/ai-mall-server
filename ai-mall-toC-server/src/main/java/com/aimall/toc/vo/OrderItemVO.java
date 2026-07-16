package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 订单明细返回 VO：订单内单个 SKU 的商品信息、成交价及数量
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("订单明细")
public class OrderItemVO {

    private Long id;
    private Long spuId;
    private Long skuId;
    private String spuName;
    private String skuSpec;
    private String image;
    private BigDecimal price;
    private Integer quantity;
}
