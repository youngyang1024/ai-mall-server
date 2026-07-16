package com.aimall.toc.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 评价查询行返回 VO：评价内容、评分、用户及商品信息（images 为 JSON 字符串，转 ReviewVO 时解析）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ReviewRowVO {
    private Long id;
    private Long spuId;
    private Long userId;
    private String nickname;
    private String avatar;
    private Integer rating;
    private String content;
    private String images;
    private String skuSpec;
    private Integer status;
    private String spuName;
    private String spuImage;
    private LocalDateTime createTime;
}
