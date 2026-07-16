package com.aimall.tob.vo;

import io.swagger.annotations.ApiModel;
import lombok.Data;

/**
 * 订单状态分布统计响应对象：承载订单状态、状态描述及对应订单数量，用于商家后台看板订单状态分布图表展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("订单状态分布")
public class OrderStatusStatVO {

    private Integer status;
    private String statusDesc;
    private Long count;
}
