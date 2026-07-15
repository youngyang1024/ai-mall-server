package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

@Data
@ApiModel("创建订单结果")
public class OrderCreateResultVO {

    private String orderNo;
    private BigDecimal payAmount;
}
