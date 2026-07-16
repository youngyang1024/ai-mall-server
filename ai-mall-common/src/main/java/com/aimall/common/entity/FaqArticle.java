package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * FAQ 帮助文章实体，对应表 t_faq_article，按分类维护常见问题的标题与内容
 *
 * @author
 * Created by Yang on 2026/07/16
 */
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
