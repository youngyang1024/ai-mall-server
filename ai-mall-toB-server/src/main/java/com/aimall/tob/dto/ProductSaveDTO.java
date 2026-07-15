package com.aimall.tob.dto;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.List;

@Data
@ApiModel("商品保存请求")
public class ProductSaveDTO {

    @ApiModelProperty("SPU ID（更新时必填）")
    private Long id;

    @NotBlank(message = "商品名称不能为空")
    private String name;

    @NotNull(message = "分类不能为空")
    private Long categoryId;

    private String description;
    private String mainImage;

    @NotNull(message = "上架状态不能为空")
    private Integer status;

    @Valid
    @NotEmpty(message = "规格维度不能为空")
    private List<SpecDTO> specs;

    @Valid
    @NotEmpty(message = "SKU列表不能为空")
    private List<SkuDTO> skus;

    private List<String> images;

    @Data
    @ApiModel("规格维度")
    public static class SpecDTO {
        @NotBlank(message = "规格名不能为空")
        private String specName;
        @NotBlank(message = "规格值不能为空")
        private String specValues;
    }

    @Data
    @ApiModel("SKU")
    public static class SkuDTO {
        @NotBlank(message = "规格JSON不能为空")
        private String specJson;
        @NotNull(message = "价格不能为空")
        private BigDecimal price;
        @NotNull(message = "库存不能为空")
        private Integer stock;
        private String image;
        private String skuCode;
    }
}
