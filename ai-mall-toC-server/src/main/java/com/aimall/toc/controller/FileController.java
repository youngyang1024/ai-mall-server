package com.aimall.toc.controller;

import com.aimall.common.exception.BusinessException;
import com.aimall.common.result.Result;
import com.aimall.common.util.ServiceTicketAttachmentValidator;
import com.aimall.toc.config.ReviewUploadConfig;
import com.aimall.toc.vo.FileUploadVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * C端文件上传接口（评价晒图），上传前对图片做严格校验后存入 AWS S3
 * <p>1. 校验文件非空，并按扩展名白名单（jpg/jpeg/png/gif/webp）校验文件类型
 * <p>2. 校验 Content-Type 必须为 image/* 且文件大小不超过 5MB（规则比工单附件严格，不复用 ServiceTicketAttachmentValidator）
 * <p>3. 校验通过后经 ReviewImageUploader 上传至 AWS S3，返回可访问的图片 URL
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "文件上传")
@RestController
@RequestMapping("/api/file")
public class FileController {

    /** 评价晒图仅允许图片，规则比工单附件严格（不含 bmp/视频，且限 5MB），故不复用 ServiceTicketAttachmentValidator */
    private static final Set<String> IMAGE_EXTENSIONS = new HashSet<>(
            Arrays.asList("jpg", "jpeg", "png", "gif", "webp"));
    private static final long MAX_SIZE = 5L * 1024 * 1024;

    private final ReviewUploadConfig.ReviewImageUploader awsS3Util;

    public FileController(ReviewUploadConfig.ReviewImageUploader awsS3Util) {
        this.awsS3Util = awsS3Util;
    }

    @ApiOperation("上传图片")
    @PostMapping("/upload")
    public Result<FileUploadVO> upload(@RequestParam("file") MultipartFile file) {
        validateImage(file);
        String url = awsS3Util.upload(file);
        FileUploadVO vo = new FileUploadVO();
        vo.setUrl(url);
        return Result.success(vo);
    }

    private void validateImage(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException("上传文件不能为空");
        }
        String extension = ServiceTicketAttachmentValidator.getExtension(file.getOriginalFilename());
        if (!IMAGE_EXTENSIONS.contains(extension)) {
            throw new BusinessException("仅支持 jpg/jpeg/png/gif/webp 格式图片");
        }
        String contentType = file.getContentType();
        if (!StringUtils.hasText(contentType) || !contentType.toLowerCase().startsWith("image/")) {
            throw new BusinessException("仅支持图片类型文件");
        }
        if (file.getSize() > MAX_SIZE) {
            throw new BusinessException("图片大小不能超过5MB");
        }
    }
}
