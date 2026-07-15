package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
@ApiModel("发货")
public class ShipOrderDTO {

    @NotBlank(message = "物流单号不能为空")
    private String logisticsNo;
}
