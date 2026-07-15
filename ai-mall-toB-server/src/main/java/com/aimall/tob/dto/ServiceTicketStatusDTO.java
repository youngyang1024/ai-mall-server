package com.aimall.tob.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * 修改工单状态
 */
@Data
public class ServiceTicketStatusDTO {

    @NotNull(message = "状态不能为空")
    private Integer status;
}
