package com.aimall.common.vo;

import lombok.Data;

import java.util.List;

/**
 * 服务工单大类选项
 */
@Data
public class ServiceCategoryOptionVO {

    private Long id;
    private String code;
    private String name;
    private String icon;
    private Integer needOrderNo;
    private List<ServiceIssueOptionVO> issues;
}
