package com.aimall.toc.mapper;

import com.aimall.common.entity.Coupon;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CouponMapper {

    Coupon selectById(@Param("id") Long id);

    List<Coupon> selectAvailable();

    int incrementReceivedCount(@Param("id") Long id);
}
