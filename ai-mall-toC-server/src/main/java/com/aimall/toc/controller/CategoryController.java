package com.aimall.toc.controller;

import com.aimall.common.entity.Category;
import com.aimall.common.result.Result;
import com.aimall.toc.service.CategoryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Api(tags = "分类")
@RestController
@RequestMapping("/api/category")
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
}
