package com.aimall.common.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 商品评价实体，对应表 t_product_review，记录用户对订单商品的评分（1-5）、评价内容、图片及规格快照，status 控制前台显示/隐藏
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ProductReview {
    private Long id;
    private Long orderId;
    private Long orderItemId;
    private Long spuId;
    private Long skuId;
    private Long userId;
    private Integer rating; // 1-5
    private String content;
    private String images; // JSON 数组字符串
    private String skuSpec; // 规格快照
    private Integer status; // 1-显示 0-隐藏
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
