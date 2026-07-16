package com.aimall.common.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单列表展示对象，用于C端我的工单及B端工单管理的列表页，包含工单号、分类、状态描述与联系方式
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ServiceTicketListVO {

    private Long id;
    private String ticketNo;
    private Long userId;
    private String categoryName;
    private String issueName;
    private String orderNo;
    private Integer status;
    private String statusDesc;
    private String contactEmail;
    private String contactPhone;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
