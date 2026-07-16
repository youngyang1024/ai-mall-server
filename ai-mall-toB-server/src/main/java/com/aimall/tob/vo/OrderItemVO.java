package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 订单明细响应对象：承载订单中单个商品项的SPU/SKU信息、规格、图片、单价、数量，用于商家后台订单详情的商品明细展示
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
