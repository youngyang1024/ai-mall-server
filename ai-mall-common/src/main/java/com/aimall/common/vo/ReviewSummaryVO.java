package com.aimall.common.vo;

import lombok.Data;

import java.math.BigDecimal;

/**
 * 商品评价汇总展示对象，包含评价总数、平均分（保留1位小数）及 1-5 星各星级的数量分布
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ReviewSummaryVO {

    private Long total;
    private BigDecimal avgRating; // 平均分，保留1位
    private Long star5Count;
    private Long star4Count;
    private Long star3Count;
    private Long star2Count;
    private Long star1Count;
}
