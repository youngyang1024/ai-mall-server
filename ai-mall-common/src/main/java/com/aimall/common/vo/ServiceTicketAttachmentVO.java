package com.aimall.common.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单附件展示对象
 */
@Data
public class ServiceTicketAttachmentVO {

    private Long id;
    private String fileName;
    private String fileUrl;
    private String fileType;
    private Long fileSize;
    private LocalDateTime createTime;
}
