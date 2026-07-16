package com.aimall.toc.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 待评价订单项返回 VO：订单项对应的商品信息、成交价、数量及订单完成时间
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class PendingReviewVO {
    private Long orderItemId;
    private String orderNo;
    private Long spuId;
    private String spuName;
    private String skuSpec;
    private String image;
    private BigDecimal price;
    private Integer quantity;
    private LocalDateTime finishTime;
}
