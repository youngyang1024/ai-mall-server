package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.service.FavoriteService;
import com.aimall.toc.vo.FavoriteItemVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

/**
 * C端心愿单（收藏）接口：收藏商品/取消收藏/收藏列表/是否已收藏/收藏总数
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "心愿单")
@RestController
@RequestMapping("/api/favorite")
public class FavoriteController {

    private final FavoriteService favoriteService;

    public FavoriteController(FavoriteService favoriteService) {
        this.favoriteService = favoriteService;
    }

    @ApiOperation("收藏商品")
    @PostMapping("/{spuId}")
    public Result<Void> add(@PathVariable Long spuId) {
        favoriteService.add(UserContext.getUserId(), spuId);
        return Result.success();
    }

    @ApiOperation("取消收藏")
    @DeleteMapping("/{spuId}")
    public Result<Void> remove(@PathVariable Long spuId) {
        favoriteService.remove(UserContext.getUserId(), spuId);
        return Result.success();
    }

    @ApiOperation("收藏列表")
    @GetMapping("/list")
    public Result<PageResult<FavoriteItemVO>> list(@RequestParam(defaultValue = "1") int pageNum,
                                                   @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(favoriteService.list(UserContext.getUserId(), pageNum, pageSize));
    }

    @ApiOperation("是否已收藏")
    @GetMapping("/check")
    public Result<Boolean> check(@RequestParam Long spuId) {
        return Result.success(favoriteService.check(UserContext.getUserId(), spuId));
    }

    @ApiOperation("收藏总数")
    @GetMapping("/count")
    public Result<Long> count() {
        return Result.success(favoriteService.count(UserContext.getUserId()));
    }
}
