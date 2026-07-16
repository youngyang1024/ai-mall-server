package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 销售趋势响应对象：承载日期与对应销售金额，用于商家后台看板销售趋势图表展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("销售趋势")
public class SalesTrendVO {

    private String date;
    private BigDecimal amount;
}
