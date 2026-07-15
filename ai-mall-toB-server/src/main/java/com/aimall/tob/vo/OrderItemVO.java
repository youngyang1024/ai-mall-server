package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

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
