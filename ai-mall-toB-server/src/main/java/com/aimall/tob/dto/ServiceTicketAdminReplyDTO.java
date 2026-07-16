package com.aimall.tob.dto;

import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.util.List;

/**
 * 管理员回复工单请求参数：承载回复内容、附件URL列表字段，用于商家后台客服工单回复
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ServiceTicketAdminReplyDTO {

    @NotBlank(message = "回复内容不能为空")
    private String content;

    private List<String> attachmentUrls;
}
