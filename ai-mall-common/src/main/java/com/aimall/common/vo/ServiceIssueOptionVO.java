package com.aimall.common.vo;

import lombok.Data;

/**
 * 服务工单问题小类选项展示对象，作为 ServiceCategoryOptionVO 的下级选项供工单提交页选择
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ServiceIssueOptionVO {

    private Long id;
    private String code;
    private String name;
}
