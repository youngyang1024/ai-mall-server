package com.aimall.tob.mapper;

import com.aimall.tob.vo.OrderStatusStatVO;
import com.aimall.tob.vo.ProductRankVO;
import com.aimall.tob.vo.SalesTrendVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

/**
 * 仪表盘统计数据访问，主表 t_order，兼涉 t_spu、t_user 多表，提供今日订单数、销售额、新增用户数、待发货订单数、销售趋势、商品排行、订单状态分布等统计查询
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface DashboardMapper {

    Long countTodayOrders();

    BigDecimal sumTodaySales();

    Long countTodayNewUsers();

    Long countPendingShipOrders();

    List<SalesTrendVO> selectSalesTrend(@Param("days") int days);

    List<ProductRankVO> selectProductRank(@Param("limit") int limit);

    List<OrderStatusStatVO> selectOrderStatusStats();
}
