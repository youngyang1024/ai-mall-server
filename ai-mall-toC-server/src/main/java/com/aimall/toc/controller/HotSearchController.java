package com.aimall.toc.controller;

import com.aimall.common.entity.HotSearch;
import com.aimall.common.result.Result;
import com.aimall.toc.mapper.HotSearchMapper;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Api(tags = "热门搜索接口")
@RestController
@RequestMapping("/api/hot-search")
public class HotSearchController {

    @Autowired
    private HotSearchMapper hotSearchMapper;

    @ApiOperation("获取启用的热门搜索列表")
    @GetMapping("/list")
    public Result<List<HotSearch>> getEnabledList() {
        return Result.success(hotSearchMapper.selectEnabled());
    }
}