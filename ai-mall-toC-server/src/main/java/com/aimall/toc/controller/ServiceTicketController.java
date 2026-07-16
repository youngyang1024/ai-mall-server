package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.common.util.AwsS3Util;
import com.aimall.common.util.ServiceTicketAttachmentValidator;
import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ServiceCategoryOptionVO;
import com.aimall.common.vo.ServiceTicketDetailVO;
import com.aimall.common.vo.ServiceTicketListVO;
import com.aimall.toc.dto.ServiceTicketCreateDTO;
import com.aimall.toc.dto.ServiceTicketReplyDTO;
import com.aimall.toc.service.ServiceTicketService;
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

import java.util.List;

/**
 * C端服务工单接口：问题选项/提交工单/我的工单列表/详情/继续跟进/完成工单/上传附件
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "服务工单")
@RestController
@RequestMapping("/api/service-ticket")
public class ServiceTicketController {

    private final ServiceTicketService serviceTicketService;
    private final AwsS3Util awsS3Util;

    public ServiceTicketController(ServiceTicketService serviceTicketService, AwsS3Util awsS3Util) {
        this.serviceTicketService = serviceTicketService;
        this.awsS3Util = awsS3Util;
    }

    @ApiOperation("服务中心问题选项")
    @GetMapping("/options")
    public Result<List<ServiceCategoryOptionVO>> options() {
        return Result.success(serviceTicketService.getOptions());
    }

    @ApiOperation("提交工单")
    @PostMapping
    public Result<String> create(@Validated @RequestBody ServiceTicketCreateDTO dto) {
        return Result.success(serviceTicketService.create(UserContext.getUserId(), dto));
    }

    @ApiOperation("我的工单列表")
    @GetMapping("/list")
    public Result<PageResult<ServiceTicketListVO>> list(@RequestParam(defaultValue = "1") int pageNum,
                                                        @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(serviceTicketService.listByUser(UserContext.getUserId(), pageNum, pageSize));
    }

    @ApiOperation("工单详情")
    @GetMapping("/{ticketNo}")
    public Result<ServiceTicketDetailVO> detail(@PathVariable String ticketNo) {
        return Result.success(serviceTicketService.detail(UserContext.getUserId(), ticketNo));
    }

    @ApiOperation("继续跟进工单")
    @PostMapping("/{ticketNo}/reply")
    public Result<Void> reply(@PathVariable String ticketNo, @Validated @RequestBody ServiceTicketReplyDTO dto) {
        serviceTicketService.reply(UserContext.getUserId(), ticketNo, dto);
        return Result.success();
    }

    @ApiOperation("完成工单")
    @PutMapping("/{ticketNo}/complete")
    public Result<Void> complete(@PathVariable String ticketNo) {
        serviceTicketService.complete(UserContext.getUserId(), ticketNo);
        return Result.success();
    }

    @ApiOperation("上传工单附件")
    @PostMapping("/upload")
    public Result<String> upload(@RequestParam("file") MultipartFile file) {
        ServiceTicketAttachmentValidator.validate(file);
        return Result.success(awsS3Util.upload(file));
    }
}
