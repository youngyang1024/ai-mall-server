package com.aimall.common.util;

import com.aimall.common.exception.BusinessException;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

/**
 * 服务工单附件校验工具
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
