package com.aimall.common.config;

import lombok.Data;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * AWS S3 配置属性
 */
@Data
@Component
@ConditionalOnProperty(prefix = "aws.s3", name = "accessKeyId")
@ConfigurationProperties(prefix = "aws.s3")
public class AwsS3Properties {
    private String accessKeyId;
    private String accessKeySecret;
    private String regionName;
    private String defaultBucket;
    private String prefix;
}
