package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 退款详情返回 VO：退款单号、关联订单、退款金额、退款状态及原因
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("退款详情")
public class RefundVO {

    private Long id;
    private String refundNo;
    private Long orderId;
    private String orderNo;
    private BigDecimal refundAmount;
    private String reason;
    private Integer status;
    private String statusDesc;
    private String rejectReason;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
