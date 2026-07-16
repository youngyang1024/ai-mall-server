package com.aimall.tob.mapper;

import com.aimall.common.entity.Coupon;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_coupon 表数据访问，提供优惠券列表查询、新增、更新、删除等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface CouponMapper {

    List<Coupon> selectAll();

    Coupon selectById(@Param("id") Long id);

    int insert(Coupon coupon);

    int update(Coupon coupon);

    int deleteById(@Param("id") Long id);
}
