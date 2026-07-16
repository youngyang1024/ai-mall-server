package com.aimall.tob.controller;

import com.aimall.common.entity.HotSearch;
import com.aimall.common.result.Result;
import com.aimall.tob.dto.HotSearchDTO;
import com.aimall.tob.service.HotSearchService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * B端热门搜索管理接口：列表/详情/创建/更新/删除
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "热门搜索管理接口")
@RestController
@RequestMapping("/admin/hot-search")
public class HotSearchController {

    @Autowired
    private HotSearchService hotSearchService;

    @ApiOperation("获取列表")
    @GetMapping("/list")
    public Result<List<HotSearch>> list() {
        return Result.success(hotSearchService.getList());
    }

    @ApiOperation("获取详情")
    @GetMapping("/{id}")
    public Result<HotSearch> getById(@PathVariable Long id) {
        return Result.success(hotSearchService.getById(id));
    }

    @ApiOperation("创建")
    @PostMapping
    public Result<?> create(@RequestBody @Validated HotSearchDTO dto) {
        hotSearchService.create(dto);
        return Result.success();
    }

    @ApiOperation("更新")
    @PutMapping
    public Result<?> update(@RequestBody @Validated HotSearchDTO dto) {
        hotSearchService.update(dto);
        return Result.success();
    }

    @ApiOperation("删除")
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        hotSearchService.delete(id);
        return Result.success();
    }
}