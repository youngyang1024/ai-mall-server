package com.aimall.toc.mapper;

import com.aimall.common.entity.Refund;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RefundMapper {

    int insert(Refund refund);

    Refund selectById(@Param("id") Long id);

    Refund selectByIdAndUserId(@Param("id") Long id, @Param("userId") Long userId);

    int countPendingByOrderId(@Param("orderId") Long orderId);

    List<Refund> selectByUserId(@Param("userId") Long userId);
}
