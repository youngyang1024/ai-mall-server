package com.aimall.common.constant;

/**
 * 用户优惠券状态枚举，定义用户已领取优惠券的使用状态（未使用、已使用、已过期）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public enum UserCouponStatus {

    UNUSED(0, "未使用"),
    USED(1, "已使用"),
    EXPIRED(2, "已过期");

    private final int code;
    private final String desc;

    UserCouponStatus(int code, String desc) {
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
