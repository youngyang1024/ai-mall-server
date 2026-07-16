package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 拒绝退款请求参数：承载拒绝原因字段，用于商家后台退款审核驳回操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("拒绝退款")
public class RefundRejectDTO {

    @NotBlank(message = "拒绝原因不能为空")
    private String rejectReason;
}
