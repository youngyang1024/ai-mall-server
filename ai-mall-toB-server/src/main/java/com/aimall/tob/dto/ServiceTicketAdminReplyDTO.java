package com.aimall.tob.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 管理员回复工单
 */
@Data
public class ServiceTicketAdminReplyDTO {

    @NotBlank(message = "回复内容不能为空")
    private String content;

    private List<String> attachmentUrls;
}
