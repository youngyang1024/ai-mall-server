package com.aimall.common.vo;

import lombok.Data;

import java.util.List;

/**
 * 服务工单问题大类选项展示对象，用于工单提交页的分类选择，包含大类信息及其下属问题小类列表
 *
 * @author
 * Created by Yang on 2026/07/16
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
