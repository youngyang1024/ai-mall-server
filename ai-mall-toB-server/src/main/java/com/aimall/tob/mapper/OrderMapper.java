package com.aimall.tob.mapper;

import com.aimall.common.entity.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface OrderMapper {

    List<Order> selectList(@Param("orderNo") String orderNo, @Param("status") Integer status);

    Order selectByOrderNo(@Param("orderNo") String orderNo);

    Order selectById(@Param("id") Long id);

    int updateShip(@Param("id") Long id, @Param("logisticsNo") String logisticsNo,
                   @Param("shipTime") LocalDateTime shipTime);

    int updateStatus(@Param("id") Long id, @Param("fromStatus") Integer fromStatus, @Param("toStatus") Integer toStatus);

    int updateToRefunded(@Param("id") Long id);
}
