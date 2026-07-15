package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务中心问题小类
 */
@Data
public class ServiceIssue {

    private Long id;
    private Long categoryId;
    private String code;
    private String name;
    private Integer sort;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
