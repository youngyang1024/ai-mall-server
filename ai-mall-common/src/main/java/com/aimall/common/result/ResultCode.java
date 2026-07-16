package com.aimall.common.result;

import lombok.Getter;

/**
 * 统一响应状态码枚举，定义 API 通用状态码及默认提示信息（成功、参数错误、未登录、无权限、资源不存在、服务器内部错误）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Getter
public enum ResultCode {

    SUCCESS(200, "success"),
    BAD_REQUEST(400, "请求参数错误"),
    UNAUTHORIZED(401, "未登录或Token已过期"),
    FORBIDDEN(403, "无权限"),
    NOT_FOUND(404, "资源不存在"),
    ERROR(500, "服务器内部错误");

    private final int code;
    private final String message;

    ResultCode(int code, String message) {
        this.code = code;
        this.message = message;
    }
}
