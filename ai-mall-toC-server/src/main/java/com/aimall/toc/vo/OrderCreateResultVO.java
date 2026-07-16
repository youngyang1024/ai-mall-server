package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 创建订单结果返回 VO：订单号及应付金额
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("创建订单结果")
public class OrderCreateResultVO {

    private String orderNo;
    private BigDecimal payAmount;
}
