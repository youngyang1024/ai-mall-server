package com.aimall.common.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * SPU 商品图片实体，对应表 t_spu_image，维护商品详情页轮播图及其排序
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class SpuImage {

    private Long id;
    private Long spuId;
    private String imageUrl;
    private Integer sort;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
