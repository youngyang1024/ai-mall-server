package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

@Data
@ApiModel("商品销量排行")
public class ProductRankVO {

    private Long spuId;
    private String name;
    private Integer salesCount;
}
