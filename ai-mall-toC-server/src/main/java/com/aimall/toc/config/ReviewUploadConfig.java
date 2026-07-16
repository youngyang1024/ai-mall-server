package com.aimall.toc.config;

import com.aimall.common.config.AwsS3Properties;
import com.aimall.common.util.AwsS3Util;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.StringUtils;

/**
 * 评价晒图上传配置，注册评价图片专用的 S3 上传器
 *
 * <p>1. 复制公共 AwsS3Properties 配置（AK/SK、Region、Bucket），在公共路径前缀后追加 review 路径段，使评价晒图独立存放
 * <p>2. 以独立包装类型 ReviewImageUploader 注册 Bean：若直接注册第二个 AwsS3Util 类型 Bean 会与 common 模块的默认 Bean 冲突
 * <p>3. 通过 @ConditionalOnProperty 仅在配置了 aws.s3.accessKeyId 时生效，未配置 S3 的环境不注册该 Bean
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Configuration
public class ReviewUploadConfig {

    public static class ReviewImageUploader extends AwsS3Util {
        public ReviewImageUploader(AwsS3Properties properties) {
            super(properties);
        }
    }

    @Bean
    @ConditionalOnProperty(prefix = "aws.s3", name = "accessKeyId")
    public ReviewImageUploader reviewImageUploader(AwsS3Properties base) {
        AwsS3Properties props = new AwsS3Properties();
        props.setAccessKeyId(base.getAccessKeyId());
        props.setAccessKeySecret(base.getAccessKeySecret());
        props.setRegionName(base.getRegionName());
        props.setDefaultBucket(base.getDefaultBucket());
        String prefix = base.getPrefix();
        if (StringUtils.hasText(prefix) && !prefix.endsWith("/")) {
            prefix += "/";
        } else if (!StringUtils.hasText(prefix)) {
            prefix = "";
        }
        props.setPrefix(prefix + "review");
        return new ReviewImageUploader(props);
    }
}
