package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.entity.UserAddress;
import com.aimall.common.result.Result;
import com.aimall.toc.dto.AddressDTO;
import com.aimall.toc.service.AddressService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "收货地址")
@RestController
@RequestMapping("/api/address")
public class AddressController {

    private final AddressService addressService;

    public AddressController(AddressService addressService) {
        this.addressService = addressService;
    }

    @ApiOperation("地址列表")
    @GetMapping("/list")
    public Result<List<UserAddress>> list() {
        return Result.success(addressService.list(UserContext.getUserId()));
    }

    @ApiOperation("新增地址")
    @PostMapping
    public Result<Void> create(@Validated @RequestBody AddressDTO dto) {
        addressService.create(UserContext.getUserId(), dto);
        return Result.success();
    }

    @ApiOperation("修改地址")
    @PutMapping("/{id}")
    public Result<Void> update(@PathVariable Long id, @Validated @RequestBody AddressDTO dto) {
        addressService.update(UserContext.getUserId(), id, dto);
        return Result.success();
    }

    @ApiOperation("删除地址")
    @DeleteMapping("/{id}")
    public Result<Void> delete(@PathVariable Long id) {
        addressService.delete(UserContext.getUserId(), id);
        return Result.success();
    }

    @ApiOperation("设为默认地址")
    @PutMapping("/{id}/default")
    public Result<Void> setDefault(@PathVariable Long id) {
        addressService.setDefault(UserContext.getUserId(), id);
        return Result.success();
    }
}
