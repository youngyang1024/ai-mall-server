package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * SKU库存调整请求参数：承载库存数量字段（不小于0），用于商家后台单个SKU的库存修改
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("SKU库存调整")
public class StockUpdateDTO {

    @NotNull(message = "库存不能为空")
    @Min(value = 0, message = "库存不能小于0")
    private Integer stock;
}
