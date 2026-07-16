package com.aimall.toc.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 收藏商品项返回 VO：SPU 商品信息、最低价及收藏时间
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class FavoriteItemVO {
    private Long spuId;
    private String spuName;
    private String mainImage;
    private Integer spuStatus;
    private BigDecimal minPrice;
    private LocalDateTime createTime;
}
