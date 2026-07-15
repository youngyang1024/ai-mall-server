package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@ApiModel("优惠券模板")
public class CouponDTO {

    private Long id;

    @NotBlank(message = "券名称不能为空")
    private String name;

    private Integer type;

    @NotNull(message = "满减门槛不能为空")
    private BigDecimal threshold;

    @NotNull(message = "减免金额不能为空")
    private BigDecimal discount;

    @NotNull(message = "发放总量不能为空")
    private Integer totalCount;

    @NotNull(message = "有效期开始不能为空")
    private LocalDateTime startTime;

    @NotNull(message = "有效期结束不能为空")
    private LocalDateTime endTime;

    private Integer status;
}
