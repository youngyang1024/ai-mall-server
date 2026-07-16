package com.aimall.tob.mapper;

import com.aimall.common.entity.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

/**
 * t_order 表数据访问，提供订单条件列表查询、发货信息更新、状态流转、退款状态更新等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface OrderMapper {

    List<Order> selectList(@Param("orderNo") String orderNo, @Param("status") Integer status,
                           @Param("userId") Long userId, @Param("startTime") String startTime,
                           @Param("endTime") String endTime);

    Order selectByOrderNo(@Param("orderNo") String orderNo);

    Order selectById(@Param("id") Long id);

    int updateShip(@Param("id") Long id, @Param("logisticsNo") String logisticsNo,
                   @Param("shipTime") LocalDateTime shipTime);

    int updateStatus(@Param("id") Long id, @Param("fromStatus") Integer fromStatus, @Param("toStatus") Integer toStatus);

    int updateToRefunded(@Param("id") Long id);
}
