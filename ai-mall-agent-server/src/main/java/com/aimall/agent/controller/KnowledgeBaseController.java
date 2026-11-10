package com.aimall.agent.controller;

import com.aimall.agent.common.Result;
import com.aimall.agent.service.KnowledgeBaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.CompletableFuture;

/**
 * 知识库管理内部接口：手动触发全量重建（B 端经 toB 转发调用或运维直调，内部 token 鉴权）
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@RestController
@RequestMapping("/agent/internal/kb")
@RequiredArgsConstructor
public class KnowledgeBaseController {

    private final KnowledgeBaseService knowledgeBaseService;

    @Value("${aimall.internal-token}")
    private String internalToken;

    /**
     * 全量重建（异步执行，进度看 t_ai_kb_sync_log）
     */
    @PostMapping("/rebuild")
    public Result<String> rebuild(@RequestHeader(value = "X-Internal-Token", required = false) String token) {
        if (!StringUtils.hasText(internalToken) || !internalToken.equals(token)) {
            throw new IllegalArgumentException("内部接口鉴权失败");
        }
        CompletableFuture.runAsync(knowledgeBaseService::fullRebuild);
        return Result.success("重建任务已提交，进度见 t_ai_kb_sync_log");
    }
}
