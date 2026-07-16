package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

/**
 * 订单详情响应对象：承载订单基本信息（订单号、用户、状态、金额、收货信息、物流单号、各节点时间）及订单明细列表，用于商家后台订单详情展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("订单详情")
public class OrderDetailVO {

    private Long id;
    private String orderNo;
    private Long userId;
    private Integer status;
    private String statusDesc;
    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private BigDecimal payAmount;
    private String receiverInfo;
    private String remark;
    private String logisticsNo;
    private LocalDateTime payTime;
    private LocalDateTime shipTime;
    private LocalDateTime finishTime;
    private LocalDateTime createTime;
    private List<OrderItemVO> items;
}
