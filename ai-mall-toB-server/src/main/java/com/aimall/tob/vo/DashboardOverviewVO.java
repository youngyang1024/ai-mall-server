package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 数据看板概览响应对象：承载今日订单数、今日销售额、今日新增用户数、待发货订单数等核心指标，用于商家后台首页看板展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("看板概览")
public class DashboardOverviewVO {

    private Long todayOrderCount;
    private BigDecimal todaySalesAmount;
    private Long todayNewUserCount;
    private Long pendingShipCount;
}
