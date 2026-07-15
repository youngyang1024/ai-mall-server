package com.aimall.toc.mapper;

import com.aimall.common.entity.UserCoupon;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface UserCouponMapper {

    UserCoupon selectByIdAndUserId(@Param("id") Long id, @Param("userId") Long userId);

    int countByUserIdAndCouponId(@Param("userId") Long userId, @Param("couponId") Long couponId);

    int insert(UserCoupon userCoupon);

    List<UserCoupon> selectByUserId(@Param("userId") Long userId, @Param("status") Integer status);

    int updateUsed(@Param("id") Long id, @Param("useTime") LocalDateTime useTime);
}
