package com.aimall.tob.controller;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.service.FaqArticleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "FAQ文章管理")
@RestController
@RequestMapping("/admin/faq/article")
public class FaqArticleController {

    @Autowired
    private FaqArticleService articleService;

    @ApiOperation("文章列表")
    @GetMapping("/list")
    public Result<PageResult<FaqArticle>> list(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String title) {
        return Result.success(articleService.getPageList(pageNum, pageSize, categoryId, title));
    }

    @ApiOperation("保存文章")
    @PostMapping("/save")
    public Result<?> save(@RequestBody FaqArticle article) {
        articleService.save(article);
        return Result.success();
    }

    @ApiOperation("修改文章")
    @PostMapping("/update")
    public Result<?> update(@RequestBody FaqArticle article) {
        articleService.update(article);
        return Result.success();
    }

    @ApiOperation("删除文章")
    @PostMapping("/delete/{id}")
    public Result<?> delete(@PathVariable Long id) {
        articleService.delete(id);
        return Result.success();
    }
}
