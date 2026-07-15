package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.List;

@Data
@ApiModel("创建订单")
public class OrderCreateDTO {

    @NotNull(message = "收货地址不能为空")
    private Long addressId;

    private List<Long> cartIds;

    private Long userCouponId;

    private String remark;
}
