package com.aimall.tob.controller;

import com.aimall.common.entity.Category;
import com.aimall.common.result.Result;
import com.aimall.tob.dto.CategoryDTO;
import com.aimall.tob.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "分类管理")
@RestController
@RequestMapping("/admin/category")
public class CategoryController {

    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @ApiOperation("分类树")
    @GetMapping("/tree")
    public Result<List<Category>> tree() {
        return Result.success(categoryService.tree());
    }

    @ApiOperation("新增分类")
    @PostMapping
    public Result<Void> create(@Validated @RequestBody CategoryDTO dto) {
        categoryService.create(dto);
        return Result.success();
    }

    @ApiOperation("修改分类")
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Long id, @Validated @RequestBody CategoryDTO dto) {
        dto.setId(id);
        categoryService.update(dto);
        return Result.success();
    }

    @ApiOperation("删除分类")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        categoryService.delete(id);
        return Result.success();
    }
}
