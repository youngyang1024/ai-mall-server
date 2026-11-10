package com.aimall.agent.service;

import com.aimall.agent.context.ChatPrincipalContext;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 每日用量限额服务：按身份维度（登录 userId / 游客 eid）Redis 计数
 *
 * <p>1. key 形如 agent:quota:{yyyyMMdd}:{u:1|g:xxx}，INCR 后当日过期；计数在进入任何模型调用之前执行
 * <p>2. 额度值来自 t_ai_setting（daily_quota_user/daily_quota_guest），本地缓存 60 秒刷新，B 端修改热生效
 * <p>3. 游客 eid 可通过清 localStorage 重置（已知可绕过），以低额度降低刷量收益，IP 级限流交由未来网关层
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class QuotaService {

    private static final String QUOTA_KEY_PREFIX = "agent:quota:";
    private static final DateTimeFormatter DAY_FORMAT = DateTimeFormatter.ofPattern("yyyyMMdd");

    /** 额度设置键与兜底默认值（表数据缺失时使用） */
    private static final String KEY_QUOTA_USER = "daily_quota_user";
    private static final String KEY_QUOTA_GUEST = "daily_quota_guest";
    private static final int DEFAULT_QUOTA_USER = 50;
    private static final int DEFAULT_QUOTA_GUEST = 10;

    private final StringRedisTemplate stringRedisTemplate;
    private final JdbcTemplate jdbcTemplate;

    /** t_ai_setting 本地缓存（60 秒定时刷新） */
    private final Map<String, Integer> settingCache = new ConcurrentHashMap<>();

    /**
     * 尝试消耗当日一条额度：未超限返回 true 并计数；超限返回 false
     */
    public boolean tryConsume() {
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        String key = QUOTA_KEY_PREFIX + LocalDate.now().format(DAY_FORMAT) + ":" + principal.principalKey();
        Long count = stringRedisTemplate.opsForValue().increment(key);
        if (count != null && count == 1L) {
            // 首条设置过期：跨到次日自动清零（25 小时冗余覆盖时钟偏差）
            stringRedisTemplate.expire(key, Duration.ofHours(25));
        }
        int quota = principal.isLogin() ? quotaOf(KEY_QUOTA_USER, DEFAULT_QUOTA_USER)
                : quotaOf(KEY_QUOTA_GUEST, DEFAULT_QUOTA_GUEST);
        return count != null && count <= quota;
    }

    /**
     * 当前身份剩余额度（前端展示用）
     */
    public int remaining() {
        ChatPrincipalContext.ChatPrincipal principal = ChatPrincipalContext.get();
        String key = QUOTA_KEY_PREFIX + LocalDate.now().format(DAY_FORMAT) + ":" + principal.principalKey();
        String used = stringRedisTemplate.opsForValue().get(key);
        int quota = principal.isLogin() ? quotaOf(KEY_QUOTA_USER, DEFAULT_QUOTA_USER)
                : quotaOf(KEY_QUOTA_GUEST, DEFAULT_QUOTA_GUEST);
        return Math.max(0, quota - (used == null ? 0 : Integer.parseInt(used)));
    }

    private int quotaOf(String settingKey, int defaultValue) {
        if (settingCache.isEmpty()) {
            refreshSettings();
        }
        return settingCache.getOrDefault(settingKey, defaultValue);
    }

    /**
     * 定时刷新额度设置（B 端修改 t_ai_setting 后最迟 60 秒生效）
     */
    @Scheduled(fixedDelay = 60000)
    public void refreshSettings() {
        try {
            jdbcTemplate.query("SELECT setting_key, setting_value FROM t_ai_setting WHERE setting_key IN (?, ?)",
                    rs -> {
                        settingCache.put(rs.getString("setting_key"), Integer.parseInt(rs.getString("setting_value")));
                    }, KEY_QUOTA_USER, KEY_QUOTA_GUEST);
        } catch (Exception e) {
            log.warn("刷新限额设置失败，沿用缓存/默认值: {}", e.getMessage());
        }
    }
}
