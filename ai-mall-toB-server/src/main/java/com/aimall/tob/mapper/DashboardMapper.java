package com.aimall.tob.mapper;

import com.aimall.tob.vo.OrderStatusStatVO;
import com.aimall.tob.vo.ProductRankVO;
import com.aimall.tob.vo.SalesTrendVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

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
