package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

@Data
@ApiModel("看板概览")
public class DashboardOverviewVO {

    private Long todayOrderCount;
    private BigDecimal todaySalesAmount;
    private Long todayNewUserCount;
    private Long pendingShipCount;
}
