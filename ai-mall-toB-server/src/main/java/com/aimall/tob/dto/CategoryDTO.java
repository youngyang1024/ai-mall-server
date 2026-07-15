package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@Data
@ApiModel("分类请求")
public class CategoryDTO {

    @ApiModelProperty("分类ID（更新时必填）")
    private Long id;

    @NotBlank(message = "分类名称不能为空")
    @ApiModelProperty(value = "分类名称", required = true)
    private String name;

    @NotNull(message = "父分类ID不能为空")
    @ApiModelProperty(value = "父分类ID，0=顶级", required = true)
    private Long parentId;

    @ApiModelProperty("排序值")
    private Integer sort;

    @ApiModelProperty("状态 1=启用 0=禁用")
    private Integer status;
}
