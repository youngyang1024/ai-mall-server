package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 首页轮播图实体，对应表 t_banner
 *
 * @author
 * Created by Yang on 2026/07/16
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
