package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

@Data
@ApiModel("订单状态分布")
public class OrderStatusStatVO {

    private Integer status;
    private String statusDesc;
    private Long count;
}
