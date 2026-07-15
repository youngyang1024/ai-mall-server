package com.aimall.toc.dto;

import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.List;

/**
 * 提交服务工单
 */
@Data
public class ServiceTicketCreateDTO {

    @NotNull(message = "Category is required")
    private Long categoryId;

    @NotNull(message = "Issue is required")
    private Long issueId;

    private String orderNo;

    @NotBlank(message = "Message is required")
    private String content;

    @NotBlank(message = "First name is required")
    private String contactFirstName;

    @NotBlank(message = "Last name is required")
    private String contactLastName;

    @NotBlank(message = "Email is required")
    @Email(message = "Email is invalid")
    private String contactEmail;

    private String contactAreaCode;

    @NotBlank(message = "Phone is required")
    private String contactPhone;

    private List<String> attachmentUrls;
}
