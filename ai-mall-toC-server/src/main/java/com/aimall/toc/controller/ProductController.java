package com.aimall.toc.controller;

import com.aimall.common.entity.Spu;
import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.service.ProductService;
import com.aimall.toc.vo.ProductDetailVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

/**
 * C端商品接口：商品列表/搜索/详情，以及热销排行、为你推荐、看了又看、买了又买等推荐位
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "商品")
@RestController
@RequestMapping("/api/product")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @ApiOperation("商品列表")
    @GetMapping("/list")
    public Result<PageResult<Spu>> list(@RequestParam(defaultValue = "1") int pageNum,
                                       @RequestParam(defaultValue = "10") int pageSize,
                                       @RequestParam(required = false) Long categoryId,
                                       @RequestParam(required = false) String sortBy,
                                       @RequestParam(required = false) BigDecimal minPrice,
                                       @RequestParam(required = false) BigDecimal maxPrice) {
        return Result.success(productService.list(categoryId, sortBy, minPrice, maxPrice, pageNum, pageSize));
    }

    @ApiOperation("商品搜索")
    @GetMapping("/search")
    public Result<PageResult<Spu>> search(@RequestParam String keyword,
                                         @RequestParam(defaultValue = "1") int pageNum,
                                         @RequestParam(defaultValue = "10") int pageSize,
                                         @RequestParam(required = false) String sortBy,
                                         @RequestParam(required = false) BigDecimal minPrice,
                                         @RequestParam(required = false) BigDecimal maxPrice) {
        return Result.success(productService.search(keyword, sortBy, minPrice, maxPrice, pageNum, pageSize));
    }

    @ApiOperation("热销排行")
    @GetMapping("/recommend/hot")
    public Result<List<Spu>> recommendHot(@RequestParam(defaultValue = "10") int limit) {
        return Result.success(productService.recommendHot(limit));
    }

    @ApiOperation("为你推荐")
    @GetMapping("/recommend/for-you")
    public Result<List<Spu>> recommendForYou(@RequestParam Long spuId,
                                             @RequestParam(defaultValue = "8") int limit) {
        return Result.success(productService.recommendForYou(spuId, limit));
    }

    @ApiOperation("看了又看")
    @GetMapping("/recommend/viewed-also")
    public Result<List<Spu>> recommendViewedAlso(@RequestParam String keyword,
                                                @RequestParam(defaultValue = "8") int limit) {
        return Result.success(productService.recommendViewedAlso(keyword, limit));
    }

    @ApiOperation("买了又买")
    @GetMapping("/recommend/bought-also")
    public Result<List<Spu>> recommendBoughtAlso(@RequestParam Long categoryId,
                                               @RequestParam(defaultValue = "8") int limit) {
        return Result.success(productService.recommendBoughtAlso(categoryId, limit));
    }

    @ApiOperation("商品详情")
    @GetMapping("/{spuId:\\d+}")
    public Result<ProductDetailVO> detail(@PathVariable Long spuId) {
        return Result.success(productService.detail(spuId));
    }
}
