package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单附件实体，对应表 t_service_ticket_attachment，记录工单或回复关联的附件文件信息（名称、URL、类型、大小）及上传方类型
 *
 * @author
 * Created by Yang on 2026/07/16
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
