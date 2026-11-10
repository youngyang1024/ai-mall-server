package com.aimall.agent.entity;

import lombok.Data;

import java.time.LocalDateTime;

/**
 * AI 消息实体，对应表 t_ai_message
 *
 * <p>1. role=user/assistant；assistant 消息通过 requestMessageId 关联触发它的用户消息
 * <p>2. agentCode 记录回答方（导购/客服/售后/规则兜底），cardsJson 存商品卡/工单确认卡等结构化内容
 * <p>3. status 流转：GENERATING -> COMPLETED/STOPPED/FAILED，停止生成时已产出部分保留
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Data
public class AiMessage {

    /** 主键ID */
    private Long id;

    /** 消息ID(UUID) */
    private String messageId;

    /** 关联的用户请求消息ID(assistant消息填写) */
    private String requestMessageId;

    /** 会话ID */
    private String sessionId;

    /** 用户ID(游客为空) */
    private Long userId;

    /** 游客标识 */
    private String eid;

    /** 消息角色 user/assistant */
    private String role;

    /** 回答方 SHOPPING_GUIDE/CUSTOMER_SERVICE/AFTER_SALES/RULE */
    private String agentCode;

    /** 消息状态 GENERATING/COMPLETED/STOPPED/FAILED */
    private String status;

    /** 文字内容 */
    private String content;

    /** 结构化卡片JSON */
    private String cardsJson;

    /** 消耗token数 */
    private Integer tokenUsage;

    /** 生成完成时间 */
    private LocalDateTime completedTime;

    /** 创建时间 */
    private LocalDateTime createTime;
}
