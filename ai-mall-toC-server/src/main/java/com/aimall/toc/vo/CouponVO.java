package com.aimall.toc.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 可领取优惠券返回 VO：券名称、门槛、优惠金额、剩余数量、有效期及是否已领取
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("可领取优惠券")
public class CouponVO {

    private Long id;
    private String name;
    private BigDecimal threshold;
    private BigDecimal discount;
    private Integer totalCount;
    private Integer receivedCount;
    private Integer remainCount;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private Boolean received;
}
