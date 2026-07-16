package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务中心问题小类实体，对应表 t_service_issue，通过 categoryId 挂靠问题大类
 *
 * @author
 * Created by Yang on 2026/07/16
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
