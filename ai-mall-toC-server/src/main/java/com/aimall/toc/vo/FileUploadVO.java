package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 文件上传返回 VO：文件访问 URL
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
