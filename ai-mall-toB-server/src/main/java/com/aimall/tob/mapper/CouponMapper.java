package com.aimall.tob.mapper;

import com.aimall.common.entity.Coupon;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CouponMapper {

    List<Coupon> selectAll();

    Coupon selectById(@Param("id") Long id);

    int insert(Coupon coupon);

    int update(Coupon coupon);

    int deleteById(@Param("id") Long id);
}
