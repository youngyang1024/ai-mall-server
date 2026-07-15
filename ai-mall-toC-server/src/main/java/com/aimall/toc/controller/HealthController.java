package com.aimall.toc.controller;

import com.aimall.common.result.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

/**
 * 健康检查
 */
@Api(tags = "健康检查")
@RestController
public class HealthController {

    @ApiOperation("服务健康检查")
    @GetMapping("/api/health")
    public Result<Map<String, Object>> health() {
        Map<String, Object> data = new HashMap<>();
        data.put("service", "ai-mall-toC-server");
        data.put("status", "UP");
        return Result.success(data);
    }
}
