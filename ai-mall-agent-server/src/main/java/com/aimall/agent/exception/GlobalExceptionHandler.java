package com.aimall.agent.exception;

import com.aimall.agent.common.Result;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

/**
 * 全局异常处理：业务参数异常返回友好提示，未知异常兜底不泄漏堆栈
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(IllegalArgumentException.class)
    public Result<Void> handleIllegalArgument(IllegalArgumentException e) {
        return Result.fail(Result.CODE_FAIL, e.getMessage());
    }

    @ExceptionHandler(Exception.class)
    public Result<Void> handleException(Exception e) {
        log.error("未处理异常", e);
        return Result.fail(Result.CODE_FAIL, "系统繁忙，请稍后再试");
    }
}
