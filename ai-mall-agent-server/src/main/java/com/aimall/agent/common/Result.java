package com.aimall.agent.common;

import lombok.Data;

/**
 * 统一响应结果，格式对齐 V1 的 Result（code/message/data），便于 C 端前端复用既有响应处理
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Data
public class Result<T> {

    /** 成功状态码 */
    public static final int CODE_SUCCESS = 200;

    /** 未登录状态码（对齐 V1 ResultCode.UNAUTHORIZED） */
    public static final int CODE_UNAUTHORIZED = 401;

    /** 业务失败状态码 */
    public static final int CODE_FAIL = 500;

    private Integer code;

    private String message;

    private T data;

    public static <T> Result<T> success(T data) {
        Result<T> result = new Result<>();
        result.setCode(CODE_SUCCESS);
        result.setMessage("success");
        result.setData(data);
        return result;
    }

    public static <T> Result<T> fail(int code, String message) {
        Result<T> result = new Result<>();
        result.setCode(code);
        result.setMessage(message);
        return result;
    }
}
