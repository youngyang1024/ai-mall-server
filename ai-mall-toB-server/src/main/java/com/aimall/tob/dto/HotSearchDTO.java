package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

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
