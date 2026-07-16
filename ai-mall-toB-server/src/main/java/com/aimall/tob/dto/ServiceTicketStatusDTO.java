package com.aimall.tob.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * 修改工单状态请求参数：承载状态字段，用于商家后台客服工单状态流转
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ServiceTicketStatusDTO {

    @NotNull(message = "状态不能为空")
    private Integer status;
}
