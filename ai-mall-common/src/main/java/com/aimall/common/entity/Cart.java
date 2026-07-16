package com.aimall.common.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * 购物车实体，对应表 t_cart，记录用户加购的 SKU、数量及勾选状态
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class Cart {

    private Long id;
    private Long userId;
    private Long skuId;
    private Integer quantity;
    private Integer checked;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
