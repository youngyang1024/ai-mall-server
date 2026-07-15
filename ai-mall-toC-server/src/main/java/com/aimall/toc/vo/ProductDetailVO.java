package com.aimall.toc.vo;

import com.aimall.common.entity.Sku;
import com.aimall.common.entity.Spu;
import com.aimall.common.entity.SpuImage;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
@ApiModel("C端商品详情")
public class ProductDetailVO {

    private Spu spu;
    private List<SpuImage> images;
    private List<Sku> skus;

    @ApiModelProperty("规格维度，key=规格名，value=可选值列表")
    private List<SpecItemVO> specs;

    @Data
    public static class SpecItemVO {
        private String specName;
        private List<String> specValues;
    }
}
