package com.aimall.common.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 商品评价展示对象，用于商品详情评价列表、我的评价及 B端评价管理，包含脱敏昵称、评分、图片列表及商品信息
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ReviewVO {

    private Long id;
    private Long spuId;
    private Long userId;
    private String nickname; // 脱敏后昵称
    private String avatar;
    private Integer rating;
    private String content;
    private List<String> images;
    private String skuSpec;
    private Integer status; // 1-显示 0-隐藏（B端用）
    private String spuName; // B端/我的评价用
    private String spuImage;
    private LocalDateTime createTime;
}
