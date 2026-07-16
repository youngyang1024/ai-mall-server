package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 商品 SKU 实体，对应表 t_sku，记录 SPU 下具体规格组合（specJson）的售价、库存、图片及 SKU 编码
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class Sku {

    private Long id;
    private Long spuId;
    private String specJson;
    private BigDecimal price;
    private Integer stock;
    private String image;
    private String skuCode;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
