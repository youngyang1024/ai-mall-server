package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 申请退款请求 DTO：订单号及退款原因
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("申请退款")
public class RefundApplyDTO {

    @NotBlank(message = "订单号不能为空")
    private String orderNo;

    @NotBlank(message = "退款原因不能为空")
    private String reason;
}
