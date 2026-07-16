package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.dto.RefundApplyDTO;
import com.aimall.toc.service.RefundService;
import com.aimall.toc.vo.RefundVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * C端退款接口：申请退款/退款列表/退款详情
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "退款")
@RestController
@RequestMapping("/api/refund")
public class RefundController {

    private final RefundService refundService;

    public RefundController(RefundService refundService) {
        this.refundService = refundService;
    }

    @ApiOperation("申请退款")
    @PostMapping("/apply")
    public Result<Void> apply(@Validated @RequestBody RefundApplyDTO dto) {
        refundService.apply(UserContext.getUserId(), dto);
        return Result.success();
    }

    @ApiOperation("退款列表")
    @GetMapping("/list")
    public Result<PageResult<RefundVO>> list(@RequestParam(defaultValue = "1") int pageNum,
                                             @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(refundService.list(UserContext.getUserId(), pageNum, pageSize));
    }

    @ApiOperation("退款详情")
    @GetMapping("/{id}")
    public Result<RefundVO> detail(@PathVariable Long id) {
        return Result.success(refundService.detail(UserContext.getUserId(), id));
    }
}
