package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.toc.dto.CartAddDTO;
import com.aimall.toc.dto.CartUpdateDTO;
import com.aimall.toc.service.CartService;
import com.aimall.toc.vo.CartItemVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "购物车")
@RestController
@RequestMapping("/api/cart")
public class CartController {

    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @ApiOperation("购物车列表")
    @GetMapping("/list")
    public Result<List<CartItemVO>> list() {
        return Result.success(cartService.list(UserContext.getUserId()));
    }

    @ApiOperation("加入购物车")
    @PostMapping("/add")
    public Result<Void> add(@Validated @RequestBody CartAddDTO dto) {
        cartService.add(UserContext.getUserId(), dto);
        return Result.success();
    }

    @ApiOperation("更新购物车")
    @PutMapping("/update")
    public Result<Void> update(@Validated @RequestBody CartUpdateDTO dto) {
        cartService.update(UserContext.getUserId(), dto);
        return Result.success();
    }

    @ApiOperation("删除购物车项")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        cartService.delete(UserContext.getUserId(), id);
        return Result.success();
    }

    @ApiOperation("清空购物车")
    @DeleteMapping("/clear")
    public Result<Void> clear() {
        cartService.clear(UserContext.getUserId());
        return Result.success();
    }
}
