package com.aimall.common.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 服务工单详情展示对象
 */
@Data
public class ServiceTicketDetailVO {

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
    private String statusDesc;
    private String contactFirstName;
    private String contactLastName;
    private String contactEmail;
    private String contactAreaCode;
    private String contactPhone;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private List<ServiceTicketReplyVO> replies;
}
