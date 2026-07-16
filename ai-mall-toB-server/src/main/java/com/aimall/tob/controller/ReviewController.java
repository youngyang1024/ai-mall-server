package com.aimall.tob.controller;

import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ReviewVO;
import com.aimall.tob.dto.ReviewStatusDTO;
import com.aimall.tob.service.ReviewService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * B端评价管理接口：列表（按商品/评分/状态分页查询）/显示或隐藏评价
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "评价管理")
@RestController
@RequestMapping("/admin/review")
public class ReviewController {

    private final ReviewService reviewService;

    public ReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @ApiOperation("评价列表")
    @GetMapping("/list")
    public Result<PageResult<ReviewVO>> list(@RequestParam(required = false) Long spuId,
                                             @RequestParam(required = false) Integer rating,
                                             @RequestParam(required = false) Integer status,
                                             @RequestParam(defaultValue = "1") int pageNum,
                                             @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(reviewService.list(spuId, rating, status, pageNum, pageSize));
    }

    @ApiOperation("显示/隐藏评价")
    @PutMapping("/{id}/status")
    public Result<Void> updateStatus(@PathVariable Long id, @Validated @RequestBody ReviewStatusDTO dto) {
        reviewService.updateStatus(id, dto.getStatus());
        return Result.success();
    }
}
