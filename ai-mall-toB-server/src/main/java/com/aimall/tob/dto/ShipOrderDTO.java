package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 订单发货请求参数：承载物流单号字段，用于商家后台订单发货操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("发货")
public class ShipOrderDTO {

    @NotBlank(message = "物流单号不能为空")
    private String logisticsNo;
}
