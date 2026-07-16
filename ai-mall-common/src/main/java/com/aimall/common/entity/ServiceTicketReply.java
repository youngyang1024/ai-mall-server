package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单回复实体，对应表 t_service_ticket_reply，记录用户与管理员在工单下的往来回复内容
 *
 * @author
 * Created by Yang on 2026/07/16
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
