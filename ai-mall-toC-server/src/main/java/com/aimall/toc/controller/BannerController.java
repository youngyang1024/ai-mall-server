package com.aimall.toc.controller;

import com.aimall.common.entity.Banner;
import com.aimall.common.result.Result;
import com.aimall.toc.service.BannerService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Api(tags = "轮播图")
@RestController
@RequestMapping("/api/banner")
public class BannerController {

    private final BannerService bannerService;

    public BannerController(BannerService bannerService) {
        this.bannerService = bannerService;
    }

    @ApiOperation("首页轮播图")
    @GetMapping("/list")
    public Result<List<Banner>> list() {
        return Result.success(bannerService.listEnabled());
    }
}
