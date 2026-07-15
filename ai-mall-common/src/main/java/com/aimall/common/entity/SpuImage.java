package com.aimall.common.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * SPU 商品图片
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
