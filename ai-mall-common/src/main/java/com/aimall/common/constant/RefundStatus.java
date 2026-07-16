package com.aimall.common.constant;

/**
 * 退款申请状态枚举，定义退款审核流程的状态（待审核、已通过、已拒绝）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public enum RefundStatus {

    PENDING(0, "待审核"),
    APPROVED(1, "已通过"),
    REJECTED(2, "已拒绝");

    private final int code;
    private final String desc;

    RefundStatus(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
