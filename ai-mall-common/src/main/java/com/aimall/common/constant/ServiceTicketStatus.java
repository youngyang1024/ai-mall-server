package com.aimall.common.constant;

/**
 * 服务工单状态枚举，定义工单处理流程的状态（待处理、处理中、已完成），并提供根据 code 获取状态描述的方法
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public enum ServiceTicketStatus {

    PENDING(0, "待处理"),
    PROCESSING(1, "处理中"),
    COMPLETED(2, "已完成");

    private final int code;
    private final String desc;

    ServiceTicketStatus(int code, String desc) {
        this.code = code;
        this.desc = desc;
    }

    public int getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }

    public static String getDescByCode(Integer code) {
        if (code == null) {
            return "";
        }
        for (ServiceTicketStatus value : values()) {
            if (value.code == code) {
                return value.desc;
            }
        }
        return "";
    }
}
