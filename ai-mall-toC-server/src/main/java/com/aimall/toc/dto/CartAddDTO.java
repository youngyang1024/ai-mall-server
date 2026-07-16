package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * 加入购物车请求 DTO：SKU 及数量
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("加入购物车")
public class CartAddDTO {
    @NotNull(message = "SKU ID不能为空")
    private Long skuId;
    @NotNull(message = "数量不能为空")
    @Min(value = 1, message = "数量至少为1")
    private Integer quantity;
}
