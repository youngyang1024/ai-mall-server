package com.aimall.tob.service;

import com.aimall.common.entity.Coupon;
import com.aimall.tob.dto.CouponDTO;

import java.util.List;

/**
 * B端优惠券管理业务接口：定义优惠券列表查询、新增、更新、删除能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface CouponService {

    List<Coupon> list();

    void create(CouponDTO dto);

    void update(CouponDTO dto);

    void delete(Long id);
}
