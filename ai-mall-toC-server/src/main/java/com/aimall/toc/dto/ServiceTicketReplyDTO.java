package com.aimall.toc.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 用户继续跟进工单请求 DTO：回复内容及附件
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ServiceTicketReplyDTO {

    @NotBlank(message = "Message is required")
    private String content;

    private List<String> attachmentUrls;
}
