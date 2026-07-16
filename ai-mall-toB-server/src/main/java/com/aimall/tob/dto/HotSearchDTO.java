package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * 热门搜索配置请求参数：承载搜索关键词、是否热门、排序值、状态字段，用于商家后台热搜词配置管理
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("热门搜索配置")
public class HotSearchDTO {
    private Long id;

    @NotBlank(message = "搜索关键词不能为空")
    private String keyword;

    @NotNull(message = "是否热门不能为空")
    private Integer isHot;

    private Integer sort;

    private Integer status;
}
