package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 轮播图新增/编辑请求参数：承载标题、图片URL、跳转链接、排序值、状态字段，用于商家后台轮播图配置管理
 *
 * @author
 * Created by Yang on 2026/07/16
 */
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
