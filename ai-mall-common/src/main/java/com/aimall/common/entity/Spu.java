package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 商品 SPU
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
