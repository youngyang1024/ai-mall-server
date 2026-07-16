package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单主表实体，对应表 t_service_ticket，记录工单号、问题分类快照、关联订单号、问题描述、处理状态、联系人信息及最后回复方
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ServiceTicket {

    private Long id;
    private String ticketNo;
    private Long userId;
    private Long categoryId;
    private String categoryName;
    private Long issueId;
    private String issueName;
    private String orderNo;
    private String content;
    private Integer status;
    private String contactFirstName;
    private String contactLastName;
    private String contactEmail;
    private String contactAreaCode;
    private String contactPhone;
    private Integer lastReplyUserType;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
