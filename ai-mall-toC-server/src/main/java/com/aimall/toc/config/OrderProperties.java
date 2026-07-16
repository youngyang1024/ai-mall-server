package com.aimall.toc.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 订单配置属性（前缀 order）：支付超时时长（默认 30 分钟）与超时兜底扫描 cron 表达式（默认每 5 分钟）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@Component
@ConfigurationProperties(prefix = "order")
public class OrderProperties {

    private int payTimeoutMinutes = 30;
    private String timeoutScanCron = "0 */5 * * * ?";
}
