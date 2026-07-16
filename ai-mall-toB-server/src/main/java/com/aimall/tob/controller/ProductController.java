package com.aimall.tob.controller;

import com.aimall.common.entity.Spu;
import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.ProductSaveDTO;
import com.aimall.tob.dto.StockUpdateDTO;
import com.aimall.tob.service.ProductService;
import com.aimall.tob.vo.ProductDetailVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * B端商品管理接口：列表（按id/名称/分类/状态分页查询）/详情/新增/修改/上下架/调整SKU库存
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "商品管理")
@RestController
@RequestMapping("/admin/product")
public class ProductController {

    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @ApiOperation("商品列表")
    @GetMapping("/list")
    public Result<PageResult<Spu>> list(@RequestParam(defaultValue = "1") int pageNum,
                                       @RequestParam(defaultValue = "10") int pageSize,
                                       @RequestParam(required = false) Long id,
                                       @RequestParam(required = false) String name,
                                       @RequestParam(required = false) Long categoryId,
                                       @RequestParam(required = false) Integer status) {
        return Result.success(productService.list(id, name, categoryId, status, pageNum, pageSize));
    }

    @ApiOperation("商品详情")
    @GetMapping("/{spuId}")
    public Result<ProductDetailVO> detail(@PathVariable Long spuId) {
        return Result.success(productService.detail(spuId));
    }

    @ApiOperation("新增商品")
    @PostMapping
    public Result<Map<String, Long>> create(@Validated @RequestBody ProductSaveDTO dto) {
        Long spuId = productService.create(dto);
        Map<String, Long> data = new HashMap<>();
        data.put("spuId", spuId);
        return Result.success(data);
    }

    @ApiOperation("修改商品")
    @PutMapping("/{spuId}")
    public Result<Void> update(@PathVariable Long spuId, @Validated @RequestBody ProductSaveDTO dto) {
        productService.update(spuId, dto);
        return Result.success();
    }

    @ApiOperation("上下架")
    @PutMapping("/{spuId}/status")
    public Result<Void> updateStatus(@PathVariable Long spuId, @RequestParam Integer status) {
        productService.updateStatus(spuId, status);
        return Result.success();
    }

    @ApiOperation("调整SKU库存")
    @PutMapping("/sku/{skuId}/stock")
    public Result<Void> updateSkuStock(@PathVariable Long skuId, @Validated @RequestBody StockUpdateDTO dto) {
        productService.updateSkuStock(skuId, dto.getStock());
        return Result.success();
    }
}
