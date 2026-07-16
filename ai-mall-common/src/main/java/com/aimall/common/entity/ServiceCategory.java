package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 服务中心问题大类实体，对应表 t_service_category，needOrderNo 标识提交该类工单时是否必须填写订单号
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class ServiceCategory {

    private Long id;
    private String code;
    private String name;
    private String icon;
    private Integer needOrderNo;
    private Integer sort;
    private Integer status;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
