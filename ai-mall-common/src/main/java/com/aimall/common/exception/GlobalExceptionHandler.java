package com.aimall.common.exception;

import com.aimall.common.result.Result;
import com.aimall.common.result.ResultCode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.BindException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Objects;

/**
 * 全局异常处理器，基于 RestControllerAdvice 统一捕获各类异常并转换为标准 Result 响应
 * <p>1. BusinessException：业务异常，透传其错误码与提示信息
 * <p>2. MethodArgumentNotValidException / BindException：参数校验和绑定失败，提取首个字段错误信息返回
 * <p>3. MissingServletRequestParameterException：缺少必填请求参数，提示具体参数名
 * <p>4. HttpMessageNotReadableException：请求体格式解析失败
 * <p>5. Exception：其余未知异常兜底，记录 error 日志并返回统一的服务器内部错误
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(BusinessException.class)
    public Result<Void> handleBusinessException(BusinessException e) {
        return Result.fail(e.getCode(), e.getMessage());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<Void> handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
        log.warn("参数校验失败: {}", e.getMessage());
        FieldError fieldError = e.getBindingResult().getFieldError();
        String message = Objects.nonNull(fieldError) ? fieldError.getDefaultMessage() : "请求参数校验失败";
        return Result.fail(message);
    }

    @ExceptionHandler(BindException.class)
    public Result<Void> handleBindException(BindException e) {
        log.warn("参数绑定失败: {}", e.getMessage());
        FieldError fieldError = e.getBindingResult().getFieldError();
        String message = Objects.nonNull(fieldError) ? fieldError.getDefaultMessage() : "请求参数绑定失败";
        return Result.fail(message);
    }

    @ExceptionHandler(MissingServletRequestParameterException.class)
    public Result<Void> handleMissingServletRequestParameterException(MissingServletRequestParameterException e) {
        log.warn("缺少请求参数: {}", e.getMessage());
        return Result.fail("缺少必要的请求参数: " + e.getParameterName());
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public Result<Void> handleHttpMessageNotReadableException(HttpMessageNotReadableException e) {
        log.warn("请求体解析失败: {}", e.getMessage());
        return Result.fail("请求参数格式错误");
    }

    @ExceptionHandler(Exception.class)
    public Result<Void> handleException(Exception e) {
        log.error("系统异常", e);
        return Result.fail(ResultCode.ERROR);
    }
}
