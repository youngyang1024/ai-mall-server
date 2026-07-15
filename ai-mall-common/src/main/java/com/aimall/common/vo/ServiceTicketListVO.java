package com.aimall.common.vo;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务工单列表展示对象
 */
@Data
public class ServiceTicketListVO {

    private Long id;
    private String ticketNo;
    private Long userId;
    private String categoryName;
    private String issueName;
    private String orderNo;
    private Integer status;
    private String statusDesc;
    private String contactEmail;
    private String contactPhone;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
