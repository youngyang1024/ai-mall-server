package com.aimall.toc.service;

import com.aimall.toc.vo.CouponVO;
import com.aimall.toc.vo.UserCouponVO;

import java.math.BigDecimal;
import java.util.List;

public interface CouponService {

    List<CouponVO> listAvailable(Long userId);

    void receive(Long userId, Long couponId);

    List<UserCouponVO> myCoupons(Long userId, Integer status);

    List<UserCouponVO> listUsable(Long userId, BigDecimal orderAmount);
}
