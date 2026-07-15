package com.aimall.toc.service.impl;

import com.aimall.common.entity.Coupon;
import com.aimall.common.entity.UserCoupon;
import com.aimall.common.exception.BusinessException;
import com.aimall.toc.mapper.CouponMapper;
import com.aimall.toc.mapper.UserCouponMapper;
import com.aimall.toc.service.CouponService;
import com.aimall.toc.vo.CouponVO;
import com.aimall.toc.vo.UserCouponVO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CouponServiceImpl implements CouponService {

    private final CouponMapper couponMapper;
    private final UserCouponMapper userCouponMapper;

    public CouponServiceImpl(CouponMapper couponMapper, UserCouponMapper userCouponMapper) {
        this.couponMapper = couponMapper;
        this.userCouponMapper = userCouponMapper;
    }

    @Override
    public List<CouponVO> listAvailable(Long userId) {
        List<Coupon> coupons = couponMapper.selectAvailable();
        List<CouponVO> result = new ArrayList<>();
        for (Coupon coupon : coupons) {
            CouponVO vo = toCouponVO(coupon);
            vo.setReceived(userCouponMapper.countByUserIdAndCouponId(userId, coupon.getId()) > 0);
            result.add(vo);
        }
        return result;
    }

    /**
     * 领取优惠券
     *
     * 流程说明：
     * 1. 校验券模板有效且未领完
     * 2. 校验用户未重复领取
     * 3. 原子递增已领取数并写入用户券记录
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void receive(Long userId, Long couponId) {
        Coupon coupon = couponMapper.selectById(couponId);
        if (coupon == null || coupon.getStatus() != 1) {
            throw new BusinessException("优惠券不存在或已停用");
        }
        LocalDateTime now = LocalDateTime.now();
        if (now.isBefore(coupon.getStartTime()) || now.isAfter(coupon.getEndTime())) {
            throw new BusinessException("优惠券不在有效期内");
        }
        if (coupon.getReceivedCount() >= coupon.getTotalCount()) {
            throw new BusinessException("优惠券已领完");
        }
        // 允许重复领取，注释掉重复领取校验
        // if (userCouponMapper.countByUserIdAndCouponId(userId, couponId) > 0) {
        //     throw new BusinessException("您已领取过该优惠券");
        // }
        int affected = couponMapper.incrementReceivedCount(couponId);
        if (affected == 0) {
            throw new BusinessException("优惠券已领完");
        }
        UserCoupon userCoupon = new UserCoupon();
        userCoupon.setUserId(userId);
        userCoupon.setCouponId(couponId);
        userCoupon.setStatus(0);
        userCouponMapper.insert(userCoupon);
    }

    @Override
    public List<UserCouponVO> myCoupons(Long userId, Integer status) {
        List<UserCoupon> list = userCouponMapper.selectByUserId(userId, status);
        return list.stream().map(this::toUserCouponVO).collect(Collectors.toList());
    }

    @Override
    public List<UserCouponVO> listUsable(Long userId, BigDecimal orderAmount) {
        List<UserCouponVO> all = myCoupons(userId, 0);
        LocalDateTime now = LocalDateTime.now();
        return all.stream()
                .filter(vo -> vo.getStartTime() != null && vo.getEndTime() != null)
                .filter(vo -> !now.isBefore(vo.getStartTime()) && !now.isAfter(vo.getEndTime()))
                .filter(vo -> orderAmount == null || orderAmount.compareTo(vo.getThreshold()) >= 0)
                .collect(Collectors.toList());
    }

    private CouponVO toCouponVO(Coupon coupon) {
        CouponVO vo = new CouponVO();
        vo.setId(coupon.getId());
        vo.setName(coupon.getName());
        vo.setThreshold(coupon.getThreshold());
        vo.setDiscount(coupon.getDiscount());
        vo.setTotalCount(coupon.getTotalCount());
        vo.setReceivedCount(coupon.getReceivedCount());
        vo.setRemainCount(coupon.getTotalCount() - coupon.getReceivedCount());
        vo.setStartTime(coupon.getStartTime());
        vo.setEndTime(coupon.getEndTime());
        return vo;
    }

    private UserCouponVO toUserCouponVO(UserCoupon userCoupon) {
        UserCouponVO vo = new UserCouponVO();
        vo.setId(userCoupon.getId());
        vo.setCouponId(userCoupon.getCouponId());
        vo.setStatus(userCoupon.getStatus());
        vo.setStatusDesc(statusDesc(userCoupon.getStatus()));
        vo.setReceiveTime(userCoupon.getReceiveTime());
        vo.setUseTime(userCoupon.getUseTime());
        Coupon coupon = couponMapper.selectById(userCoupon.getCouponId());
        if (coupon != null) {
            vo.setCouponName(coupon.getName());
            vo.setThreshold(coupon.getThreshold());
            vo.setDiscount(coupon.getDiscount());
            vo.setStartTime(coupon.getStartTime());
            vo.setEndTime(coupon.getEndTime());
        }
        return vo;
    }

    private String statusDesc(Integer status) {
        if (status == null) {
            return "";
        }
        switch (status) {
            case 0: return "未使用";
            case 1: return "已使用";
            case 2: return "已过期";
            default: return "未知";
        }
    }
}
