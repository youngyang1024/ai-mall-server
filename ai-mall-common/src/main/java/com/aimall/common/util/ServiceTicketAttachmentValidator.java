package com.aimall.common.util;

import com.aimall.common.exception.BusinessException;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

/**
 * 服务工单附件校验工具类，校验上传附件的格式与大小，不符合规则时抛出 BusinessException
 * <p>1. 非空校验：文件为空直接拒绝
 * <p>2. 格式校验：按文件扩展名判断类型，图片仅支持 jpg/jpeg/gif/png/bmp，视频仅支持 mp4/rmvb
 * <p>3. 大小校验：图片不超过 30MB，视频不超过 50MB
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public final class ServiceTicketAttachmentValidator {

    private static final Set<String> IMAGE_EXTENSIONS = new HashSet<>(
            Arrays.asList("jpg", "jpeg", "gif", "png", "bmp"));
    private static final Set<String> VIDEO_EXTENSIONS = new HashSet<>(
            Arrays.asList("mp4", "rmvb"));
    private static final long IMAGE_MAX_SIZE = 30L * 1024 * 1024;
    private static final long VIDEO_MAX_SIZE = 50L * 1024 * 1024;

    private ServiceTicketAttachmentValidator() {
    }

    public static void validate(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new BusinessException("上传文件不能为空");
        }
        String extension = getExtension(file.getOriginalFilename());
        if (!StringUtils.hasText(extension)) {
            throw new BusinessException("文件格式不支持");
        }
        if (IMAGE_EXTENSIONS.contains(extension)) {
            if (file.getSize() > IMAGE_MAX_SIZE) {
                throw new BusinessException("图片大小不能超过30MB");
            }
            return;
        }
        if (VIDEO_EXTENSIONS.contains(extension)) {
            if (file.getSize() > VIDEO_MAX_SIZE) {
                throw new BusinessException("视频大小不能超过50MB");
            }
            return;
        }
        throw new BusinessException("仅支持 jpg/jpeg/gif/png/bmp/mp4/rmvb 格式");
    }

    public static String getExtension(String fileName) {
        if (!StringUtils.hasText(fileName) || !fileName.contains(".")) {
            return "";
        }
        return fileName.substring(fileName.lastIndexOf('.') + 1).toLowerCase(Locale.ROOT);
    }
}
