package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单附件
 */
@Data
public class ServiceTicketAttachment {

    private Long id;
    private Long ticketId;
    private Long replyId;
    private Integer userType;
    private String fileName;
    private String fileUrl;
    private String fileType;
    private Long fileSize;
    private LocalDateTime createTime;
}
