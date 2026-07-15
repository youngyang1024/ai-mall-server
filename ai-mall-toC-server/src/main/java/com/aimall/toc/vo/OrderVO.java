package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Data
@ApiModel("订单")
public class OrderVO {

    private Long id;
    private String orderNo;
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
