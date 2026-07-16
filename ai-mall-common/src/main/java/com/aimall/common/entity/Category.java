package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 商品分类实体，对应表 t_category，通过 parentId 支持多级分类，children 字段用于组装树形结构
 *
 * @author
 * Created by Yang on 2026/07/16
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
