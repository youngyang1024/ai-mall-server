package com.aimall.tob.vo;

import com.aimall.common.entity.Sku;
import com.aimall.common.entity.Spu;
import com.aimall.common.entity.SpuImage;
import com.aimall.common.entity.SpuSpec;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

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
