package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 文件上传响应
 */
@Data
@ApiModel("文件上传响应")
public class FileUploadVO {

    @ApiModelProperty("文件访问URL")
    private String url;
}
