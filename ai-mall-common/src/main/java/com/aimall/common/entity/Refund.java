package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 退款申请实体，对应表 t_refund，记录退款单号、退款金额、申请原因、审核状态及申请前订单状态（用于拒绝后回退）
 *
 * @author
 * Created by Yang on 2026/07/16
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
