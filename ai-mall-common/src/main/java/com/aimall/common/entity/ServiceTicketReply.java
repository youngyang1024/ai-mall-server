package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单回复
 */
@Data
public class ServiceTicketReply {

    private Long id;
    private Long ticketId;
    private Integer userType;
    private Long userId;
    private String content;
    private LocalDateTime createTime;
}
