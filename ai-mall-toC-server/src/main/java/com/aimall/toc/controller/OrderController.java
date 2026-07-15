package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.dto.OrderCreateDTO;
import com.aimall.toc.service.OrderService;
import com.aimall.toc.vo.OrderCreateResultVO;
import com.aimall.toc.vo.OrderVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@Api(tags = "订单")
@RestController
@RequestMapping("/api/order")
public class OrderController {

    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @ApiOperation("创建订单")
    @PostMapping("/create")
    public Result<OrderCreateResultVO> create(@Validated @RequestBody OrderCreateDTO dto) {
        return Result.success(orderService.create(UserContext.getUserId(), dto));
    }

    @ApiOperation("模拟支付")
    @PostMapping("/{orderNo}/pay")
    public Result<Void> pay(@PathVariable String orderNo) {
        orderService.pay(UserContext.getUserId(), orderNo);
        return Result.success();
    }

    @ApiOperation("取消订单")
    @PostMapping("/{orderNo}/cancel")
    public Result<Void> cancel(@PathVariable String orderNo) {
        orderService.cancel(UserContext.getUserId(), orderNo);
        return Result.success();
    }

    @ApiOperation("确认收货")
    @PutMapping("/{orderNo}/confirm")
    public Result<Void> confirm(@PathVariable String orderNo) {
        orderService.confirm(UserContext.getUserId(), orderNo);
        return Result.success();
    }

    @ApiOperation("订单列表")
    @GetMapping("/list")
    public Result<PageResult<OrderVO>> list(@RequestParam(required = false) Integer status,
                                            @RequestParam(defaultValue = "1") int pageNum,
                                            @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(orderService.list(UserContext.getUserId(), status, pageNum, pageSize));
    }

    @ApiOperation("订单详情")
    @GetMapping("/{orderNo}")
    public Result<OrderVO> detail(@PathVariable String orderNo) {
        return Result.success(orderService.detail(UserContext.getUserId(), orderNo));
    }
}
