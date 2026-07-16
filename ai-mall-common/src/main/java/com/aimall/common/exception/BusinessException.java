package com.aimall.common.exception;

import com.aimall.common.result.ResultCode;
import lombok.Getter;

/**
 * 业务异常类，携带错误码 code，供 Service 层主动抛出业务校验失败信息，由 GlobalExceptionHandler 统一捕获并转换为 Result 响应
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Getter
public class BusinessException extends RuntimeException {

    private final int code;

    public BusinessException(String message) {
        super(message);
        this.code = ResultCode.ERROR.getCode();
    }

    public BusinessException(ResultCode resultCode) {
        super(resultCode.getMessage());
        this.code = resultCode.getCode();
    }

    public BusinessException(int code, String message) {
        super(message);
        this.code = code;
    }
}
