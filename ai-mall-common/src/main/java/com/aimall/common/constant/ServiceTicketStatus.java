package com.aimall.common.constant;

/**
 * 服务工单状态
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
