package com.aimall.common.vo;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 服务工单回复展示对象，包含回复方类型及描述（用户/管理员）、回复内容与附件列表，用于工单详情的往来记录展示
 *
 * @author
 * Created by Yang on 2026/07/16
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
