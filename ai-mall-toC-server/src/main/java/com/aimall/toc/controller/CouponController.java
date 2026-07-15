package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.toc.service.CouponService;
import com.aimall.toc.vo.CouponVO;
import com.aimall.toc.vo.UserCouponVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@Api(tags = "优惠券")
@RestController
@RequestMapping("/api/coupon")
public class CouponController {

    private final CouponService couponService;

    public CouponController(CouponService couponService) {
        this.couponService = couponService;
    }

    @ApiOperation("可领取优惠券列表")
    @GetMapping("/available")
    public Result<List<CouponVO>> available() {
        return Result.success(couponService.listAvailable(UserContext.getUserId()));
    }

    @ApiOperation("领取优惠券")
    @PostMapping("/{couponId}/receive")
    public Result<Void> receive(@PathVariable Long couponId) {
        couponService.receive(UserContext.getUserId(), couponId);
        return Result.success();
    }

    @ApiOperation("我的优惠券")
    @GetMapping("/my")
    public Result<List<UserCouponVO>> my(@RequestParam(required = false) Integer status) {
        return Result.success(couponService.myCoupons(UserContext.getUserId(), status));
    }

    @ApiOperation("结算可用优惠券")
    @GetMapping("/usable")
    public Result<List<UserCouponVO>> usable(@RequestParam BigDecimal orderAmount) {
        return Result.success(couponService.listUsable(UserContext.getUserId(), orderAmount));
    }
}
