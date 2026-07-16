package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * 用户详情响应对象（基本信息 + 汇总统计，不含密码）：承载用户基本信息（用户名、昵称、手机号、头像、状态、时间）及订单总数、消费总额（已支付口径：status IN (1,2,3)）、退款单数、工单数等统计字段，用于商家后台用户详情展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("用户详情")
public class UserDetailVO {

    private Long id;
    private String username;
    private String nickname;
    private String phone;
    private String avatar;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;

    /** 订单总数 */
    private Long orderCount;
    /** 消费总额（已支付口径：status IN (1,2,3)） */
    private BigDecimal totalPayAmount;
    /** 退款单数 */
    private Long refundCount;
    /** 工单数 */
    private Long ticketCount;
}
