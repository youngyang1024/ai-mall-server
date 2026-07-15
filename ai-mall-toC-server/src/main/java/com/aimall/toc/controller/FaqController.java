package com.aimall.toc.controller;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.entity.FaqCategory;
import com.aimall.common.result.Result;
import com.aimall.toc.service.FaqService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Api(tags = "C端帮助中心")
@RestController
@RequestMapping("/api/faq")
public class FaqController {

    @Autowired
    private FaqService faqService;

    @ApiOperation("获取所有启用的分类")
    @GetMapping("/category/list")
    public Result<List<FaqCategory>> getCategoryList() {
        return Result.success(faqService.getCategoryList());
    }

    @ApiOperation("根据条件获取文章")
    @GetMapping("/article/list")
    public Result<List<FaqArticle>> getArticleList(
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String keyword) {
        return Result.success(faqService.getArticleList(categoryId, keyword));
    }
}
