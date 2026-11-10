package com.aimall.agent.controller;

import com.aimall.agent.common.Result;
import com.aimall.agent.entity.AiMessage;
import com.aimall.agent.entity.AiSession;
import com.aimall.agent.service.AiSessionService;
import com.aimall.agent.service.QuotaService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * AI 会话接口：会话列表、历史消息、游客登录绑定、剩余额度
 *
 * <p>1. 全部经 ChatAuthInterceptor 双身份解析（登录 Token 或 X-Guest-Eid）
 * <p>2. /session/bind 供 C 端登录成功后调用，将游客期会话迁移到登录用户
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@RestController
@RequestMapping("/agent/session")
@RequiredArgsConstructor
public class SessionController {

    private final AiSessionService aiSessionService;
    private final QuotaService quotaService;

    @GetMapping("/list")
    public Result<List<AiSession>> list() {
        return Result.success(aiSessionService.listSessions());
    }

    @GetMapping("/{sessionId}/messages")
    public Result<List<AiMessage>> messages(@PathVariable String sessionId,
                                            @RequestParam(defaultValue = "1") int page,
                                            @RequestParam(defaultValue = "50") int size) {
        return Result.success(aiSessionService.listMessages(sessionId, page, Math.min(size, 100)));
    }

    /**
     * 游客登录后绑定会话（body: {"eid": "xxx"}）
     */
    @PostMapping("/bind")
    public Result<Void> bind(@RequestBody Map<String, String> body) {
        aiSessionService.bindGuestSessions(body.get("eid"));
        return Result.success(null);
    }

    @GetMapping("/quota")
    public Result<Map<String, Object>> quota() {
        Map<String, Object> data = new LinkedHashMap<>();
        data.put("remaining", quotaService.remaining());
        return Result.success(data);
    }
}
