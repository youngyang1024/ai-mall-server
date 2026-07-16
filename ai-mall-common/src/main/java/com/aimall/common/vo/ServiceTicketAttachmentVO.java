package com.aimall.common.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单附件展示对象，包含附件的文件名、访问 URL、类型及大小，挂载在工单详情或回复下展示
 *
 * @author
 * Created by Yang on 2026/07/16
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
