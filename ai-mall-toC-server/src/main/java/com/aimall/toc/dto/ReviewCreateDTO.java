package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.util.List;

/**
 * 发表商品评价请求 DTO：订单项、评分（1-5星）、评价内容及晒图
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("发表评价")
public class ReviewCreateDTO {
    @NotNull(message = "订单项ID不能为空")
    private Long orderItemId;
    @NotNull(message = "评分不能为空")
    @Min(value = 1, message = "评分最低1星")
    @Max(value = 5, message = "评分最高5星")
    private Integer rating;
    @Size(max = 1000, message = "评价内容不能超过1000字")
    private String content;
    @Size(max = 6, message = "晒图最多6张")
    private List<String> images;
}
