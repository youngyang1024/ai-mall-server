package com.aimall.agent.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.embedding.EmbeddingModel;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 模型连通性冒烟接口（仅开发验证用）
 *
 * <p>1. /agent/smoke/chat 验证中转站对话模型（Claude）连通性
 * <p>2. /agent/smoke/embedding 验证硅基流动 Embedding 模型（bge-m3）连通性并返回向量维度
 * <p>3. P1 搭建期使用，后续接口全部就绪后可按需下线
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@RestController
@RequestMapping("/agent/smoke")
@RequiredArgsConstructor
public class SmokeTestController {

    private final ChatModel chatModel;
    private final EmbeddingModel embeddingModel;

    @GetMapping("/chat")
    public Map<String, Object> chat() {
        Map<String, Object> result = new LinkedHashMap<>();
        long start = System.currentTimeMillis();
        String reply = chatModel.call("请只回复两个字：在线");
        result.put("costMs", System.currentTimeMillis() - start);
        result.put("reply", reply);
        return result;
    }

    @GetMapping("/embedding")
    public Map<String, Object> embedding() {
        Map<String, Object> result = new LinkedHashMap<>();
        long start = System.currentTimeMillis();
        float[] vector = embeddingModel.embed("我想买个原木风沙发");
        result.put("costMs", System.currentTimeMillis() - start);
        result.put("dimension", vector.length);
        result.put("sample", new float[]{vector[0], vector[1], vector[2]});
        return result;
    }
}
