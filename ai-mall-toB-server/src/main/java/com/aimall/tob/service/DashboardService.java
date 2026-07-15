package com.aimall.tob.service;

import com.aimall.tob.vo.DashboardOverviewVO;
import com.aimall.tob.vo.OrderStatusStatVO;
import com.aimall.tob.vo.ProductRankVO;
import com.aimall.tob.vo.SalesTrendVO;

import java.util.List;

public interface DashboardService {

    DashboardOverviewVO overview();

    List<SalesTrendVO> salesTrend(int period);

    List<ProductRankVO> productRank();

    List<OrderStatusStatVO> orderStatus();
}
