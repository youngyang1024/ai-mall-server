package com.aimall.tob.controller;

import com.aimall.common.result.Result;
import com.aimall.common.util.AwsS3Util;
import com.aimall.common.util.ServiceTicketAttachmentValidator;
import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ServiceTicketDetailVO;
import com.aimall.common.vo.ServiceTicketListVO;
import com.aimall.tob.dto.ServiceTicketAdminReplyDTO;
import com.aimall.tob.dto.ServiceTicketStatusDTO;
import com.aimall.tob.service.ServiceTicketService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * B端服务工单接口
 */
@Api(tags = "服务工单管理")
@RestController
@RequestMapping("/admin/service-ticket")
public class ServiceTicketController {

    private final ServiceTicketService serviceTicketService;
    private final AwsS3Util awsS3Util;

    public ServiceTicketController(ServiceTicketService serviceTicketService, AwsS3Util awsS3Util) {
        this.serviceTicketService = serviceTicketService;
        this.awsS3Util = awsS3Util;
    }

    @ApiOperation("工单列表")
    @GetMapping("/list")
    public Result<PageResult<ServiceTicketListVO>> list(@RequestParam(required = false) Integer status,
                                                        @RequestParam(required = false) String ticketNo,
                                                        @RequestParam(required = false) String orderNo,
                                                        @RequestParam(defaultValue = "1") int pageNum,
                                                        @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(serviceTicketService.list(status, ticketNo, orderNo, pageNum, pageSize));
    }

    @ApiOperation("工单详情")
    @GetMapping("/{id}")
    public Result<ServiceTicketDetailVO> detail(@PathVariable Long id) {
        return Result.success(serviceTicketService.detail(id));
    }

    @ApiOperation("回复工单")
    @PostMapping("/{id}/reply")
    public Result<Void> reply(@PathVariable Long id, @Validated @RequestBody ServiceTicketAdminReplyDTO dto) {
        serviceTicketService.reply(id, dto);
        return Result.success();
    }

    @ApiOperation("修改工单状态")
    @PutMapping("/{id}/status")
    public Result<Void> updateStatus(@PathVariable Long id, @Validated @RequestBody ServiceTicketStatusDTO dto) {
        serviceTicketService.updateStatus(id, dto.getStatus());
        return Result.success();
    }

    @ApiOperation("上传工单附件")
    @PostMapping("/upload")
    public Result<String> upload(@RequestParam("file") MultipartFile file) {
        ServiceTicketAttachmentValidator.validate(file);
        return Result.success(awsS3Util.upload(file));
    }
}
