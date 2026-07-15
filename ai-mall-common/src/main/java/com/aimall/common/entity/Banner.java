package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 首页轮播图
 */
@Data
public class Banner {

    private Long id;
    private String title;
    private String imageUrl;
    private String linkUrl;
    private Integer sort;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
