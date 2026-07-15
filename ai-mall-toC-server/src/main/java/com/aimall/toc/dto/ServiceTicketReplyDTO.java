package com.aimall.toc.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 用户继续跟进工单
 */
@Data
public class ServiceTicketReplyDTO {

    @NotBlank(message = "Message is required")
    private String content;

    private List<String> attachmentUrls;
}
