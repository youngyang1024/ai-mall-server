package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * 创建订单请求 DTO：收货地址、结算购物车项、用户优惠券及订单备注
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("创建订单")
public class OrderCreateDTO {

    @NotNull(message = "收货地址不能为空")
    private Long addressId;

    private List<Long> cartIds;

    private Long userCouponId;

    private String remark;
}
