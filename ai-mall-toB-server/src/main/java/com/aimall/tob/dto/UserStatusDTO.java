package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

/**
 * 用户状态修改请求参数：承载状态字段（取值0或1），用于商家后台用户的启用/禁用管理
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("用户状态修改")
public class UserStatusDTO {

    @NotNull(message = "状态不能为空")
    @Min(value = 0, message = "状态只能为0或1")
    @Max(value = 1, message = "状态只能为0或1")
    private Integer status;
}
