package com.aimall.toc.service;

import com.aimall.toc.vo.CouponVO;
import com.aimall.toc.vo.UserCouponVO;

import java.math.BigDecimal;
import java.util.List;

/**
 * C端优惠券服务接口：可领取优惠券列表/领券/我的优惠券/下单可用券查询
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface CouponService {

    List<CouponVO> listAvailable(Long userId);

    void receive(Long userId, Long couponId);

    List<UserCouponVO> myCoupons(Long userId, Integer status);

    List<UserCouponVO> listUsable(Long userId, BigDecimal orderAmount);
}
