package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 商品分类
 */
@Data
public class Category {

    private Long id;
    private String name;
    private Long parentId;
    private Integer sort;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /** 子分类（树形结构用） */
    private List<Category> children;
}
