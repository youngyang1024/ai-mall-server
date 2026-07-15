package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 退款申请
 */
@Data
public class Refund {

    private Long id;
    private String refundNo;
    private Long orderId;
    private Long userId;
    private BigDecimal refundAmount;
    private String reason;
    private Integer status;
    private Integer orderStatusBefore;
    private String rejectReason;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
