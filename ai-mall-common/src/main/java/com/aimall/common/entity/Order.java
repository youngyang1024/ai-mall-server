package com.aimall.common.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 订单实体，对应表 t_order，记录订单金额（总额/优惠/实付）、状态、收货信息快照、物流单号及各节点时间
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class Order {

    private Long id;
    private String orderNo;
    private Long userId;
    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private BigDecimal payAmount;
    private Long couponId;
    private Integer status;
    private String receiverInfo;
    private String remark;
    private String logisticsNo;
    private LocalDateTime payTime;
    private LocalDateTime shipTime;
    private LocalDateTime finishTime;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
