package com.aimall.tob.controller;

import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.ShipOrderDTO;
import com.aimall.tob.service.OrderService;
import com.aimall.tob.vo.OrderDetailVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@Api(tags = "订单管理")
@RestController
@RequestMapping("/admin/order")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @ApiOperation("订单列表")
    @GetMapping("/list")
    public Result<PageResult<OrderDetailVO>> list(@RequestParam(required = false) String orderNo,
                                                  @RequestParam(required = false) Integer status,
                                                  @RequestParam(defaultValue = "1") int pageNum,
                                                  @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(orderService.list(orderNo, status, pageNum, pageSize));
    }

    @ApiOperation("订单详情")
    @GetMapping("/{orderNo}")
    public Result<OrderDetailVO> detail(@PathVariable String orderNo) {
        return Result.success(orderService.detail(orderNo));
    }

    @ApiOperation("发货")
    @PutMapping("/{orderNo}/ship")
    public Result<Void> ship(@PathVariable String orderNo, @Validated @RequestBody ShipOrderDTO dto) {
        orderService.ship(orderNo, dto);
        return Result.success();
    }
}
