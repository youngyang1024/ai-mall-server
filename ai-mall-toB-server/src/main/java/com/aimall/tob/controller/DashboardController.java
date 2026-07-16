package com.aimall.tob.controller;

import com.aimall.common.result.Result;
import com.aimall.tob.service.DashboardService;
import com.aimall.tob.vo.DashboardOverviewVO;
import com.aimall.tob.vo.OrderStatusStatVO;
import com.aimall.tob.vo.ProductRankVO;
import com.aimall.tob.vo.SalesTrendVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * B端数据看板接口：概览指标/销售趋势（按周期）/商品销量排行/订单状态分布
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "数据看板")
@RestController
@RequestMapping("/admin/dashboard")
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @ApiOperation("概览指标")
    @GetMapping("/overview")
    public Result<DashboardOverviewVO> overview() {
        return Result.success(dashboardService.overview());
    }

    @ApiOperation("销售趋势")
    @GetMapping("/sales-trend")
    public Result<List<SalesTrendVO>> salesTrend(@RequestParam(defaultValue = "7") int period) {
        return Result.success(dashboardService.salesTrend(period));
    }

    @ApiOperation("商品销量排行")
    @GetMapping("/product-rank")
    public Result<List<ProductRankVO>> productRank() {
        return Result.success(dashboardService.productRank());
    }

    @ApiOperation("订单状态分布")
    @GetMapping("/order-status")
    public Result<List<OrderStatusStatVO>> orderStatus() {
        return Result.success(dashboardService.orderStatus());
    }
}
