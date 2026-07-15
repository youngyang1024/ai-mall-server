package com.aimall.tob.controller;

import com.aimall.common.entity.Coupon;
import com.aimall.common.result.Result;
import com.aimall.tob.dto.CouponDTO;
import com.aimall.tob.service.CouponService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "优惠券管理")
@RestController
@RequestMapping("/admin/coupon")
public class CouponController {

    private final CouponService couponService;

    public CouponController(CouponService couponService) {
        this.couponService = couponService;
    }

    @ApiOperation("优惠券列表")
    @GetMapping("/list")
    public Result<List<Coupon>> list() {
        return Result.success(couponService.list());
    }

    @ApiOperation("新增优惠券")
    @PostMapping
    public Result<Void> create(@Validated @RequestBody CouponDTO dto) {
        couponService.create(dto);
        return Result.success();
    }

    @ApiOperation("修改优惠券")
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Long id, @Validated @RequestBody CouponDTO dto) {
        dto.setId(id);
        couponService.update(dto);
        return Result.success();
    }

    @ApiOperation("删除优惠券")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        couponService.delete(id);
        return Result.success();
    }
}
