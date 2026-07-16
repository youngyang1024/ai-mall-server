package com.aimall.common.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 热门搜索词实体，对应表 t_hot_search，维护搜索页展示的推荐关键词及其热门标记、排序与启用状态
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class HotSearch {
    private Long id;
    private String keyword;
    private Integer isHot; // 0-否 1-是
    private Integer sort;
    private Integer status; // 0-禁用 1-启用
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
