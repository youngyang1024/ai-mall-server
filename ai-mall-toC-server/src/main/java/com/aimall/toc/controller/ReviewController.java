package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ReviewSummaryVO;
import com.aimall.common.vo.ReviewVO;
import com.aimall.toc.dto.ReviewCreateDTO;
import com.aimall.toc.service.ReviewService;
import com.aimall.toc.vo.PendingReviewVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * C端商品评价接口：发表评价/商品评价列表与汇总（公开）/待评价列表/我的评价
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "商品评价")
@RestController
@RequestMapping("/api/review")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @ApiOperation("发表评价")
    @PostMapping
    public Result<Void> create(@Validated @RequestBody ReviewCreateDTO dto) {
        reviewService.create(UserContext.getUserId(), dto);
        return Result.success();
    }

    @ApiOperation("商品评价列表（公开）")
    @GetMapping("/list")
    public Result<PageResult<ReviewVO>> list(@RequestParam Long spuId,
                                             @RequestParam(required = false) Integer rating,
                                             @RequestParam(defaultValue = "1") int pageNum,
                                             @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(reviewService.listBySpu(spuId, rating, pageNum, pageSize));
    }

    @ApiOperation("商品评价汇总（公开）")
    @GetMapping("/summary")
    public Result<ReviewSummaryVO> summary(@RequestParam Long spuId) {
        return Result.success(reviewService.summary(spuId));
    }

    @ApiOperation("待评价列表")
    @GetMapping("/pending")
    public Result<PageResult<PendingReviewVO>> pending(@RequestParam(defaultValue = "1") int pageNum,
                                                       @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(reviewService.pending(UserContext.getUserId(), pageNum, pageSize));
    }

    @ApiOperation("我的评价")
    @GetMapping("/my")
    public Result<PageResult<ReviewVO>> my(@RequestParam(defaultValue = "1") int pageNum,
                                           @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(reviewService.myReviews(UserContext.getUserId(), pageNum, pageSize));
    }
}
