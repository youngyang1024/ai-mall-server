package com.aimall.toc.mapper;

import com.aimall.common.entity.Coupon;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 优惠券表 Mapper：查询可领取的优惠券及单券详情，含已领取数量条件自增（防超发）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface CouponMapper {

    Coupon selectById(@Param("id") Long id);

    List<Coupon> selectAvailable();

    int incrementReceivedCount(@Param("id") Long id);
}
