package com.aimall.tob.mapper;

import com.aimall.common.entity.OrderItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_order_item 表数据访问，提供按订单 ID 查询订单明细等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface OrderItemMapper {

    List<OrderItem> selectByOrderId(@Param("orderId") Long orderId);
}
