package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 * 商品销量排行响应对象：承载SPU ID、商品名称、销量，用于商家后台看板商品销量排行榜展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("商品销量排行")
public class ProductRankVO {

    private Long spuId;
    private String name;
    private Integer salesCount;
}
