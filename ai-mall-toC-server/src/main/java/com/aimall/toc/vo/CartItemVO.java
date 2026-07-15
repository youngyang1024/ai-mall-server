package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

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
