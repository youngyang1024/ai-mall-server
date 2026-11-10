package com.aimall.agent.service;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Agent 配置服务：从 t_ai_agent_config 加载提示词/温度/启停，本地缓存 + 60 秒轮询热生效
 *
 * <p>1. B 端保存配置后最迟 60 秒生效，无需重启（P4 再补 Redis pub/sub 即时通知，轮询为兜底）
 * <p>2. 按 version 变化判断是否刷新缓存，刷新时打印日志便于核对生效情况
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AgentConfigService {

    private final JdbcTemplate jdbcTemplate;

    private final Map<String, AgentConfig> cache = new ConcurrentHashMap<>();

    /**
     * 获取 Agent 配置（缓存未命中时同步加载）
     *
     * @throws IllegalStateException 配置不存在或已停用
     */
    public AgentConfig get(String agentCode) {
        if (cache.isEmpty()) {
            refresh();
        }
        AgentConfig config = cache.get(agentCode);
        if (config == null || !config.isEnabled()) {
            throw new IllegalStateException("Agent 配置缺失或已停用: " + agentCode);
        }
        return config;
    }

    /**
     * 定时刷新配置（60 秒轮询兜底热生效）
     */
    @Scheduled(fixedDelay = 60000)
    public void refresh() {
        try {
            jdbcTemplate.query("SELECT agent_code, agent_name, system_prompt, temperature, model_provider_id, enabled, version FROM t_ai_agent_config",
                    rs -> {
                        String code = rs.getString("agent_code");
                        AgentConfig old = cache.get(code);
                        int version = rs.getInt("version");
                        if (old != null && old.getVersion() == version) {
                            return;
                        }
                        AgentConfig config = new AgentConfig();
                        config.setAgentCode(code);
                        config.setAgentName(rs.getString("agent_name"));
                        config.setSystemPrompt(rs.getString("system_prompt"));
                        config.setTemperature(rs.getBigDecimal("temperature"));
                        config.setModelProviderId((Long) rs.getObject("model_provider_id"));
                        config.setEnabled(rs.getBoolean("enabled"));
                        config.setVersion(version);
                        cache.put(code, config);
                        if (old != null) {
                            log.info("Agent 配置热更新生效 agentCode={} version={} -> {}", code, old.getVersion(), version);
                        }
                    });
        } catch (Exception e) {
            log.warn("刷新 Agent 配置失败，沿用缓存: {}", e.getMessage());
        }
    }

    /**
     * Agent 配置缓存对象
     */
    @Data
    public static class AgentConfig {
        private String agentCode;
        private String agentName;
        private String systemPrompt;
        private BigDecimal temperature;
        private Long modelProviderId;
        private boolean enabled;
        private int version;
    }
}
