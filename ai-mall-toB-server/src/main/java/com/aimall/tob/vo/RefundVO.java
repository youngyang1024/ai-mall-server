package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 退款详情响应对象：承载退款单号、关联订单、退款金额、退款原因、状态及描述、退款前订单状态、拒绝原因、创建/更新时间，用于商家后台退款单列表与详情展示
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
    private Long userId;
    private BigDecimal refundAmount;
    private String reason;
    private Integer status;
    private String statusDesc;
    private Integer orderStatusBefore;
    private String rejectReason;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
