package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单主表
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
