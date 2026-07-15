package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

@Data
@ApiModel("轮播图")
public class BannerDTO {

    private Long id;

    private String title;

    @NotBlank(message = "图片URL不能为空")
    private String imageUrl;

    private String linkUrl;

    private Integer sort;

    private Integer status;
}
