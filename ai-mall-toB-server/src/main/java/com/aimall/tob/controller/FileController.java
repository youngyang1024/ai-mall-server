package com.aimall.tob.controller;

import com.aimall.common.result.Result;
import com.aimall.common.util.AwsS3Util;
import com.aimall.tob.vo.FileUploadVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * 文件上传接口：B端文件管理接口，提供图片上传（经 AwsS3Util 上传至 S3 并返回访问 URL）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "文件管理")
@RestController
@RequestMapping("/admin/file")
public class FileController {

    private final AwsS3Util awsS3Util;

    public FileController(AwsS3Util awsS3Util) {
        this.awsS3Util = awsS3Util;
    }

    @ApiOperation("上传图片")
    @PostMapping("/upload")
    public Result<FileUploadVO> upload(@RequestParam("file") MultipartFile file) {
        String url = awsS3Util.upload(file);
        FileUploadVO vo = new FileUploadVO();
        vo.setUrl(url);
        return Result.success(vo);
    }
}
