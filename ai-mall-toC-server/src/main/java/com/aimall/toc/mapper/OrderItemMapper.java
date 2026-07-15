package com.aimall.toc.mapper;

import com.aimall.common.entity.OrderItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderItemMapper {

    int batchInsert(@Param("items") List<OrderItem> items);

    List<OrderItem> selectByOrderId(@Param("orderId") Long orderId);

    List<Long> selectCoPurchasedSpuIds(@Param("categoryId") Long categoryId, @Param("limit") int limit);
}
