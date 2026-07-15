package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
@ApiModel("拒绝退款")
public class RefundRejectDTO {

    @NotBlank(message = "拒绝原因不能为空")
    private String rejectReason;
}
