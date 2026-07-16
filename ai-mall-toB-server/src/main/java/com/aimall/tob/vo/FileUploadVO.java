package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 文件上传响应对象：承载上传成功后的文件访问URL，用于商家后台文件/图片上传结果返回
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("文件上传响应")
public class FileUploadVO {

    @ApiModelProperty("文件访问URL")
    private String url;
}
