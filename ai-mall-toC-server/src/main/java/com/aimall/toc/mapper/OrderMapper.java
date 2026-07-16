package com.aimall.toc.mapper;

import com.aimall.common.entity.Order;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 订单表 Mapper：订单创建与查询，以及支付、完成、退款等状态流转更新（含超时未支付订单查询）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
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
