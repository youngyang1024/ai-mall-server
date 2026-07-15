package com.aimall.common.util;

import cn.hutool.core.util.IdUtil;
import com.aimall.common.config.AwsS3Properties;
import com.aimall.common.exception.BusinessException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 * AWS S3 文件存储工具
 */
@Slf4j
@Component
@ConditionalOnProperty(prefix = "aws.s3", name = "accessKeyId")
public class AwsS3Util {

    private final AwsS3Properties awsS3Properties;
    private AmazonS3 amazonS3;

    public AwsS3Util(AwsS3Properties awsS3Properties) {
        this.awsS3Properties = awsS3Properties;
    }

    @PostConstruct
    public void init() {
        BasicAWSCredentials credentials = new BasicAWSCredentials(
                awsS3Properties.getAccessKeyId(),
                awsS3Properties.getAccessKeySecret()
        );
        this.amazonS3 = AmazonS3ClientBuilder.standard()
                .withRegion(awsS3Properties.getRegionName())
                .withCredentials(new AWSStaticCredentialsProvider(credentials))
                .build();
    }

    /**
     * 上传文件到 AWS S3
     */
    public String upload(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException("上传文件不能为空");
        }
        String originalFilename = file.getOriginalFilename();
        String extension = "";
        if (StringUtils.hasText(originalFilename) && originalFilename.contains(".")) {
            extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String datePath = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));
        
        // 拼接 object key, 包含前缀
        String objectKey = awsS3Properties.getPrefix();
        if (StringUtils.hasText(objectKey) && !objectKey.endsWith("/")) {
            objectKey += "/";
        } else if (!StringUtils.hasText(objectKey)) {
            objectKey = "";
        }
        objectKey += datePath + "/" + IdUtil.simpleUUID() + extension;

        try {
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(file.getSize());
            metadata.setContentType(file.getContentType());
            
            PutObjectRequest request = new PutObjectRequest(
                    awsS3Properties.getDefaultBucket(),
                    objectKey,
                    file.getInputStream(),
                    metadata
            ).withCannedAcl(CannedAccessControlList.PublicRead);
            
            amazonS3.putObject(request);
            return getPublicUrl(objectKey);
        } catch (IOException e) {
            log.error("文件上传 AWS S3 失败", e);
            throw new BusinessException("文件上传失败");
        }
    }

    /**
     * 删除 S3 中的文件
     */
    public void delete(String objectKey) {
        if (!StringUtils.hasText(objectKey)) {
            return;
        }
        String key = extractObjectKey(objectKey);
        amazonS3.deleteObject(awsS3Properties.getDefaultBucket(), key);
    }

    /**
     * 获取文件公开访问 URL
     */
    public String getPublicUrl(String objectKey) {
        return "https://" + awsS3Properties.getDefaultBucket() + ".s3." + awsS3Properties.getRegionName() + ".amazonaws.com/" + objectKey;
    }

    private String extractObjectKey(String urlOrKey) {
        if (!urlOrKey.startsWith("http")) {
            return urlOrKey;
        }
        String prefix = "https://" + awsS3Properties.getDefaultBucket() + ".s3." + awsS3Properties.getRegionName() + ".amazonaws.com/";
        if (urlOrKey.startsWith(prefix)) {
            return urlOrKey.substring(prefix.length());
        }
        return urlOrKey;
    }
}
