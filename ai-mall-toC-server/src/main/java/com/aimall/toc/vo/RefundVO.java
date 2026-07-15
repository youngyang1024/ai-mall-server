package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

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
