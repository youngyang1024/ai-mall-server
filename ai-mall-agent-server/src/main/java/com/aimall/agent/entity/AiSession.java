package com.aimall.agent.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * AI 会话实体，对应表 t_ai_session
 *
 * <p>1. userId 与 eid 至少其一非空：登录用户记 userId，游客记前端 localStorage 生成的 eid
 * <p>2. 游客登录后通过绑定操作将 eid 名下会话迁移到 userId，历史不丢失
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Data
public class AiSession {

    /** 主键ID */
    private Long id;

    /** 会话ID(UUID) */
    private String sessionId;

    /** 用户ID(游客为空) */
    private Long userId;

    /** 游客标识 */
    private String eid;

    /** 会话标题(首条用户消息截断) */
    private String title;

    /** 会话状态 ACTIVE/CLOSED */
    private String status;

    /** 最后活跃时间 */
    private LocalDateTime lastActiveTime;

    /** 创建时间 */
    private LocalDateTime createTime;

    /** 更新时间 */
    private LocalDateTime updateTime;
}
