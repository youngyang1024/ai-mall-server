package com.aimall.tob.service;

import com.aimall.tob.vo.DashboardOverviewVO;
import com.aimall.tob.vo.OrderStatusStatVO;
import com.aimall.tob.vo.ProductRankVO;
import com.aimall.tob.vo.SalesTrendVO;

import java.util.List;

/**
 * B端数据看板业务接口：定义经营概览、销售趋势、商品销量排行、订单状态统计查询能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface DashboardService {

    DashboardOverviewVO overview();

    List<SalesTrendVO> salesTrend(int period);

    List<ProductRankVO> productRank();

    List<OrderStatusStatVO> orderStatus();
}
