package com.aimall.tob.vo;

import com.aimall.common.entity.Sku;
import com.aimall.common.entity.Spu;
import com.aimall.common.entity.SpuImage;
import com.aimall.common.entity.SpuSpec;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * 商品详情响应对象：承载SPU信息、规格维度列表、SKU列表、商品图片列表，用于商家后台商品详情/编辑页数据展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("商品详情")
public class ProductDetailVO {

    @ApiModelProperty("SPU信息")
    private Spu spu;

    @ApiModelProperty("规格维度")
    private List<SpuSpec> specs;

    @ApiModelProperty("SKU列表")
    private List<Sku> skus;

    @ApiModelProperty("商品图片")
    private List<SpuImage> images;
}
