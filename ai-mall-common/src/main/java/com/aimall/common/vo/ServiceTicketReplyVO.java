package com.aimall.common.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 服务工单回复展示对象
 */
@Data
public class ServiceTicketReplyVO {

    private Long id;
    private Integer userType;
    private String userTypeDesc;
    private Long userId;
    private String content;
    private LocalDateTime createTime;
    private List<ServiceTicketAttachmentVO> attachments;
}
