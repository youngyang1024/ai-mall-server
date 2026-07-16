package com.aimall.common.constant;

/**
 * 订单状态枚举，定义订单从待支付到已退款的完整状态流转（待支付、待发货、已发货、已完成、已取消、退款中、已退款）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public enum OrderStatus {

    UNPAID(0, "待支付"),
    PAID(1, "待发货"),
    SHIPPED(2, "已发货"),
    COMPLETED(3, "已完成"),
    CANCELLED(4, "已取消"),
    REFUNDING(5, "退款中"),
    REFUNDED(6, "已退款");

    private final int code;
    private final String desc;

    OrderStatus(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }

    public static OrderStatus of(int code) {
        for (OrderStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知订单状态: " + code);
    }
}
