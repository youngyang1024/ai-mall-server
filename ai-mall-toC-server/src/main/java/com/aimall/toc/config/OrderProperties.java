package com.aimall.toc.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Data
@Component
@ConfigurationProperties(prefix = "order")
public class OrderProperties {

    private int payTimeoutMinutes = 30;
    private String timeoutScanCron = "0 */5 * * * ?";
}
