package com.aimall.common.constant;

/**
 * 服务工单参与人类型
 */
public enum ServiceTicketUserType {

    USER(1, "用户"),
    ADMIN(2, "管理员");

    private final int code;
    private final String desc;

    ServiceTicketUserType(int code, String desc) {
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
