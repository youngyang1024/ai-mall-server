package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 购物车项返回 VO：SKU 商品信息、价格、库存、数量及勾选状态
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("购物车项")
public class CartItemVO {

    private Long id;
    private Long skuId;
    private Long spuId;
    private String spuName;
    private String skuSpec;
    private String image;
    private BigDecimal price;
    private Integer stock;
    private Integer quantity;
    private Integer checked;
    private Integer spuStatus;
}
