package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * FAQ 帮助文章分类实体，对应表 t_faq_category
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class FaqCategory {
    private Long id;
    private String name;
    private Integer sort;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
