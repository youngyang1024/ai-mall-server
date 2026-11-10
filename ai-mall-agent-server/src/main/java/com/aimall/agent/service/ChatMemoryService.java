package com.aimall.agent.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 短期记忆服务：会话内最近 N 轮对话上下文（Redis List，30 分钟滑动 TTL）
 *
 * <p>1. key=agent:mem:{sessionId}，元素为 {role, content} JSON，LPUSH+LTRIM 保留最近 N 轮
 * <p>2. 每次读写都刷新 TTL（滑动过期）；会话冷却 30 分钟后记忆自然消失，历史仍可从 MySQL 回看
 * <p>3. 只存文字内容不存卡片：卡片是展示层产物，模型上下文里用文字摘要即可
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class ChatMemoryService {

    private static final String MEMORY_KEY_PREFIX = "agent:mem:";

    /** 保留最近消息条数（用户+AI 各算一条，约 10 轮） */
    private static final int MAX_MESSAGES = 20;

    private static final Duration MEMORY_TTL = Duration.ofMinutes(30);

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    private final StringRedisTemplate stringRedisTemplate;

    /**
     * 追加一条消息到会话记忆
     */
    public void append(String sessionId, String role, String content) {
        try {
            Map<String, String> item = new LinkedHashMap<>();
            item.put("role", role);
            item.put("content", content);
            String key = MEMORY_KEY_PREFIX + sessionId;
            stringRedisTemplate.opsForList().leftPush(key, OBJECT_MAPPER.writeValueAsString(item));
            stringRedisTemplate.opsForList().trim(key, 0, MAX_MESSAGES - 1);
            stringRedisTemplate.expire(key, MEMORY_TTL);
        } catch (Exception e) {
            log.warn("写入短期记忆失败 sessionId={}: {}", sessionId, e.getMessage());
        }
    }

    /**
     * 读取会话记忆（时间正序），并刷新滑动 TTL
     */
    public List<Map<String, String>> history(String sessionId) {
        List<Map<String, String>> result = new ArrayList<>();
        try {
            String key = MEMORY_KEY_PREFIX + sessionId;
            List<String> items = stringRedisTemplate.opsForList().range(key, 0, MAX_MESSAGES - 1);
            if (items != null) {
                // LPUSH 存储为倒序，反转为时间正序
                for (int i = items.size() - 1; i >= 0; i--) {
                    result.add(OBJECT_MAPPER.readValue(items.get(i), new TypeReference<>() {
                    }));
                }
                stringRedisTemplate.expire(key, MEMORY_TTL);
            }
        } catch (Exception e) {
            log.warn("读取短期记忆失败 sessionId={}: {}", sessionId, e.getMessage());
        }
        return result;
    }
}
