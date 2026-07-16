package com.aimall.tob.controller;

import com.aimall.common.entity.FaqCategory;
import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.service.FaqCategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * B端FAQ分类管理接口：分页列表/保存/修改/删除
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "FAQ分类管理")
@RestController
@RequestMapping("/admin/faq/category")
public class FaqCategoryController {

    @Autowired
    private FaqCategoryService categoryService;

    @ApiOperation("分类列表")
    @GetMapping("/list")
    public Result<PageResult<FaqCategory>> list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        return Result.success(categoryService.getPageList(pageNum, pageSize));
    }

    @ApiOperation("保存分类")
    @PostMapping("/save")
    public Result<?> save(@RequestBody FaqCategory category) {
        categoryService.save(category);
        return Result.success();
    }

    @ApiOperation("修改分类")
    @PostMapping("/update")
    public Result<?> update(@RequestBody FaqCategory category) {
        categoryService.update(category);
        return Result.success();
    }

    @ApiOperation("删除分类")
    @PostMapping("/delete/{id}")
    public Result<?> delete(@PathVariable Long id) {
        categoryService.delete(id);
        return Result.success();
    }
}
