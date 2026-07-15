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
