package com.aimall.tob.service.impl;

import com.aimall.common.entity.Coupon;
import com.aimall.common.exception.BusinessException;
import com.aimall.tob.dto.CouponDTO;
import com.aimall.tob.mapper.CouponMapper;
import com.aimall.tob.service.CouponService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * B端优惠券管理服务实现，基于 CouponMapper 提供列表与增删改；新增/更新前校验有效期结束时间不早于开始时间，新增时 type 与 status 缺省为 1，更新/删除前校验记录存在
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class CouponServiceImpl implements CouponService {

    private final CouponMapper couponMapper;

    public CouponServiceImpl(CouponMapper couponMapper) {
        this.couponMapper = couponMapper;
    }

    @Override
    public List<Coupon> list() {
        return couponMapper.selectAll();
    }

    @Override
    public void create(CouponDTO dto) {
        validateTime(dto);
        Coupon coupon = toEntity(dto);
        if (coupon.getType() == null) {
            coupon.setType(1);
        }
        if (coupon.getStatus() == null) {
            coupon.setStatus(1);
        }
        couponMapper.insert(coupon);
    }

    @Override
    public void update(CouponDTO dto) {
        if (dto.getId() == null) {
            throw new BusinessException("优惠券ID不能为空");
        }
        Coupon exist = couponMapper.selectById(dto.getId());
        if (exist == null) {
            throw new BusinessException("优惠券不存在");
        }
        validateTime(dto);
        couponMapper.update(toEntity(dto));
    }

    @Override
    public void delete(Long id) {
        Coupon exist = couponMapper.selectById(id);
        if (exist == null) {
            throw new BusinessException("优惠券不存在");
        }
        couponMapper.deleteById(id);
    }

    private void validateTime(CouponDTO dto) {
        if (dto.getEndTime().isBefore(dto.getStartTime())) {
            throw new BusinessException("有效期结束时间不能早于开始时间");
        }
    }

    private Coupon toEntity(CouponDTO dto) {
        Coupon coupon = new Coupon();
        coupon.setId(dto.getId());
        coupon.setName(dto.getName());
        coupon.setType(dto.getType());
        coupon.setThreshold(dto.getThreshold());
        coupon.setDiscount(dto.getDiscount());
        coupon.setTotalCount(dto.getTotalCount());
        coupon.setStartTime(dto.getStartTime());
        coupon.setEndTime(dto.getEndTime());
        coupon.setStatus(dto.getStatus());
        return coupon;
    }
}
