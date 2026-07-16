package com.aimall.common.constant;

/**
 * 服务工单参与人类型枚举，区分工单回复/附件的来源方（用户、管理员）
 *
 * @author
 * Created by Yang on 2026/07/16
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
