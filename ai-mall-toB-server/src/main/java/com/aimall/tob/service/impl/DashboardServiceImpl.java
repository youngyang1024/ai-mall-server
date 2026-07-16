package com.aimall.tob.service.impl;

import com.aimall.common.constant.OrderStatus;
import com.aimall.tob.mapper.DashboardMapper;
import com.aimall.tob.service.DashboardService;
import com.aimall.tob.vo.DashboardOverviewVO;
import com.aimall.tob.vo.OrderStatusStatVO;
import com.aimall.tob.vo.ProductRankVO;
import com.aimall.tob.vo.SalesTrendVO;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * B端数据看板服务实现，基于 DashboardMapper 聚合统计：今日订单数/销售额/新增用户/待发货数概览、近 7 或 30 天销售趋势、商品销量 Top10 排行、订单状态分布（附状态描述）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class DashboardServiceImpl implements DashboardService {

    private final DashboardMapper dashboardMapper;

    public DashboardServiceImpl(DashboardMapper dashboardMapper) {
        this.dashboardMapper = dashboardMapper;
    }

    @Override
    public DashboardOverviewVO overview() {
        DashboardOverviewVO vo = new DashboardOverviewVO();
        vo.setTodayOrderCount(dashboardMapper.countTodayOrders());
        vo.setTodaySalesAmount(dashboardMapper.sumTodaySales());
        vo.setTodayNewUserCount(dashboardMapper.countTodayNewUsers());
        vo.setPendingShipCount(dashboardMapper.countPendingShipOrders());
        return vo;
    }

    @Override
    public List<SalesTrendVO> salesTrend(int period) {
        int days = period == 30 ? 30 : 7;
        return dashboardMapper.selectSalesTrend(days);
    }

    @Override
    public List<ProductRankVO> productRank() {
        return dashboardMapper.selectProductRank(10);
    }

    @Override
    public List<OrderStatusStatVO> orderStatus() {
        List<OrderStatusStatVO> stats = dashboardMapper.selectOrderStatusStats();
        for (OrderStatusStatVO stat : stats) {
            stat.setStatusDesc(OrderStatus.of(stat.getStatus()).getDesc());
        }
        return stats;
    }
}
