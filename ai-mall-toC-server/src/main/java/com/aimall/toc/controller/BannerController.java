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

/**
 * C端轮播图接口：查询首页启用中的 Banner 列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
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
