package com.aimall.tob.service;

import com.aimall.common.entity.Coupon;
import com.aimall.tob.dto.CouponDTO;

import java.util.List;

public interface CouponService {

    List<Coupon> list();

    void create(CouponDTO dto);

    void update(CouponDTO dto);

    void delete(Long id);
}
