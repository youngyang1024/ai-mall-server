package com.aimall.toc.mapper;

import com.aimall.common.entity.OrderItem;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 订单明细表 Mapper：订单项批量插入与查询，及基于同类目共同购买记录的推荐查询
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface OrderItemMapper {

    int batchInsert(@Param("items") List<OrderItem> items);

    OrderItem selectById(@Param("id") Long id);

    List<OrderItem> selectByOrderId(@Param("orderId") Long orderId);

    List<Long> selectCoPurchasedSpuIds(@Param("categoryId") Long categoryId, @Param("limit") int limit);
}
