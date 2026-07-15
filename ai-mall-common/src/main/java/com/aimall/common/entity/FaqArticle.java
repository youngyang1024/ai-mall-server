package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class FaqArticle {
    private Long id;
    private Long categoryId;
    private String title;
    private String content;
    private Integer sort;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
