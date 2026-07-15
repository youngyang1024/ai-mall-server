package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

@Data
@ApiModel("销售趋势")
public class SalesTrendVO {

    private String date;
    private BigDecimal amount;
}
