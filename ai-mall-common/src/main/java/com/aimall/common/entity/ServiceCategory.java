package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务中心问题大类
 */
@Data
public class ServiceCategory {

    private Long id;
    private String code;
    private String name;
    private String icon;
    private Integer needOrderNo;
    private Integer sort;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
