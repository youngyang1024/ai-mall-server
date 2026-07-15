package com.aimall.toc.mapper;

import com.aimall.common.entity.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface OrderMapper {

    int insert(Order order);

    Order selectByOrderNo(@Param("orderNo") String orderNo);

    Order selectByOrderNoAndUserId(@Param("orderNo") String orderNo, @Param("userId") Long userId);

    Order selectById(@Param("id") Long id);

    List<Order> selectByUserId(@Param("userId") Long userId, @Param("status") Integer status);

    int updateStatus(@Param("id") Long id, @Param("fromStatus") Integer fromStatus, @Param("toStatus") Integer toStatus);

    int updatePaid(@Param("id") Long id, @Param("payTime") LocalDateTime payTime);

    int updateCompleted(@Param("id") Long id, @Param("finishTime") LocalDateTime finishTime);

    int updateToRefunded(@Param("id") Long id);

    List<Order> selectExpiredUnpaid(@Param("beforeTime") LocalDateTime beforeTime);
}
