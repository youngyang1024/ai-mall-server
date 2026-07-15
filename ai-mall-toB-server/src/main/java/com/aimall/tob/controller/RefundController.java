package com.aimall.tob.controller;

import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.RefundRejectDTO;
import com.aimall.tob.service.RefundService;
import com.aimall.tob.vo.RefundVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@Api(tags = "退款审核")
@RestController
@RequestMapping("/admin/refund")
public class RefundController {

    private final RefundService refundService;

    public RefundController(RefundService refundService) {
        this.refundService = refundService;
    }

    @ApiOperation("退款列表")
    @GetMapping("/list")
    public Result<PageResult<RefundVO>> list(@RequestParam(required = false) Integer status,
                                             @RequestParam(defaultValue = "1") int pageNum,
                                             @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(refundService.list(status, pageNum, pageSize));
    }

    @ApiOperation("退款详情")
    @GetMapping("/{id}")
    public Result<RefundVO> detail(@PathVariable Long id) {
        return Result.success(refundService.detail(id));
    }

    @ApiOperation("审核通过")
    @PutMapping("/{id}/approve")
    public Result<Void> approve(@PathVariable Long id) {
        refundService.approve(id);
        return Result.success();
    }

    @ApiOperation("审核拒绝")
    @PutMapping("/{id}/reject")
    public Result<Void> reject(@PathVariable Long id, @Validated @RequestBody RefundRejectDTO dto) {
        refundService.reject(id, dto);
        return Result.success();
    }
}
