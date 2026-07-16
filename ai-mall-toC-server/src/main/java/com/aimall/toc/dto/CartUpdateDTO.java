package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * 更新购物车项请求 DTO：数量、勾选状态及换选 SKU
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("更新购物车")
public class CartUpdateDTO {
    @NotNull(message = "购物车ID不能为空")
    private Long id;
    @NotNull(message = "数量不能为空")
    @Min(value = 1, message = "数量至少为1")
    private Integer quantity;
    private Integer checked;
    private Long skuId;
}
