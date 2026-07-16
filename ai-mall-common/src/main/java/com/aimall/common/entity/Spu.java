package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 商品 SPU 实体，对应表 t_spu，记录商品基础信息（名称、分类、描述、主图、上架状态、销量），categoryName 与 minPrice 为查询展示用非表字段
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class Spu {

    private Long id;
    private String name;
    private Long categoryId;
    private String description;
    private String mainImage;
    private Integer status;
    private Integer salesCount;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /** 分类名称（查询展示用） */
    private String categoryName;

    /** 最低 SKU 售价（列表展示，非表字段） */
    private BigDecimal minPrice;
}
