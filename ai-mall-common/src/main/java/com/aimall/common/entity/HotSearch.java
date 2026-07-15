package com.aimall.common.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 热门搜索词
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
