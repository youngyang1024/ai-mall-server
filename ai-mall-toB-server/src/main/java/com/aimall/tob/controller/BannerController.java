package com.aimall.tob.controller;

import com.aimall.common.entity.Banner;
import com.aimall.common.result.Result;
import com.aimall.tob.dto.BannerDTO;
import com.aimall.tob.service.BannerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * B端轮播图管理接口：列表/新增/修改/删除
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "轮播图管理")
@RestController
@RequestMapping("/admin/banner")
public class BannerController {

    private final BannerService bannerService;

    public BannerController(BannerService bannerService) {
        this.bannerService = bannerService;
    }

    @ApiOperation("轮播图列表")
    @GetMapping("/list")
    public Result<List<Banner>> list() {
        return Result.success(bannerService.list());
    }

    @ApiOperation("新增轮播图")
    @PostMapping
    public Result<Void> create(@Validated @RequestBody BannerDTO dto) {
        bannerService.create(dto);
        return Result.success();
    }

    @ApiOperation("修改轮播图")
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Long id, @Validated @RequestBody BannerDTO dto) {
        dto.setId(id);
        bannerService.update(dto);
        return Result.success();
    }

    @ApiOperation("删除轮播图")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        bannerService.delete(id);
        return Result.success();
    }
}
