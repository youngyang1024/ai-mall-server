-- V2 AI 导购智能体：会话/消息 + Agent 配置 + 模型厂商 + 知识库同步日志 + AI 通用设置
-- 执行方式：mysql -u<user> -p ai_mall < v2_ai_agent.sql
-- 说明：user_id 与 eid 至少其一非空（游客用前端生成的 eid 标识，登录后绑定 user_id）

-- AI 会话表
CREATE TABLE IF NOT EXISTS `t_ai_session` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `session_id` VARCHAR(64) NOT NULL COMMENT '会话ID(UUID)',
    `user_id` BIGINT DEFAULT NULL COMMENT '用户ID(游客为空)',
    `eid` VARCHAR(64) DEFAULT NULL COMMENT '游客标识(前端localStorage生成)',
    `title` VARCHAR(128) DEFAULT NULL COMMENT '会话标题(首条用户消息截断)',
    `status` VARCHAR(16) NOT NULL DEFAULT 'ACTIVE' COMMENT '会话状态 ACTIVE=活跃 CLOSED=关闭',
    `last_active_time` DATETIME DEFAULT NULL COMMENT '最后活跃时间',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_session_id` (`session_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_eid` (`eid`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'AI会话表';

-- AI 消息表
CREATE TABLE IF NOT EXISTS `t_ai_message` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `message_id` VARCHAR(64) NOT NULL COMMENT '消息ID(UUID)',
    `request_message_id` VARCHAR(64) DEFAULT NULL COMMENT '关联的用户请求消息ID(assistant消息填写)',
    `session_id` VARCHAR(64) NOT NULL COMMENT '会话ID',
    `user_id` BIGINT DEFAULT NULL COMMENT '用户ID(游客为空)',
    `eid` VARCHAR(64) DEFAULT NULL COMMENT '游客标识',
    `role` VARCHAR(16) NOT NULL COMMENT '消息角色 user=用户 assistant=AI',
    `agent_code` VARCHAR(32) DEFAULT NULL COMMENT '回答方 SHOPPING_GUIDE=导购 CUSTOMER_SERVICE=客服 AFTER_SALES=售后 RULE=规则兜底',
    `status` VARCHAR(16) NOT NULL DEFAULT 'COMPLETED' COMMENT '消息状态 GENERATING=生成中 COMPLETED=完成 STOPPED=已停止 FAILED=失败',
    `content` TEXT COMMENT '文字内容',
    `cards_json` TEXT COMMENT '结构化卡片JSON(商品卡/工单确认卡)',
    `token_usage` INT DEFAULT NULL COMMENT '本条消息消耗token数',
    `completed_time` DATETIME DEFAULT NULL COMMENT '生成完成时间',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_message_id` (`message_id`),
    KEY `idx_session_id` (`session_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'AI消息表';

-- Agent 配置表（B端动态管理，热生效）
CREATE TABLE IF NOT EXISTS `t_ai_agent_config` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `agent_code` VARCHAR(32) NOT NULL COMMENT 'Agent编码 COORDINATOR=路由 SHOPPING_GUIDE=导购 CUSTOMER_SERVICE=客服 AFTER_SALES=售后',
    `agent_name` VARCHAR(64) NOT NULL COMMENT 'Agent名称',
    `system_prompt` TEXT NOT NULL COMMENT '系统提示词(B端可编辑,热生效)',
    `temperature` DECIMAL(3, 2) NOT NULL DEFAULT 0.70 COMMENT '温度参数',
    `model_provider_id` BIGINT DEFAULT NULL COMMENT '指定模型厂商ID(空则用默认厂商)',
    `enabled` TINYINT NOT NULL DEFAULT 1 COMMENT '启用状态 1=启用 0=停用',
    `version` INT NOT NULL DEFAULT 1 COMMENT '版本号(每次编辑+1,用于热生效轮询与历史关联)',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_agent_code` (`agent_code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'AI Agent配置表';

-- Agent 提示词版本历史表（可回滚）
CREATE TABLE IF NOT EXISTS `t_ai_agent_config_history` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `agent_code` VARCHAR(32) NOT NULL COMMENT 'Agent编码',
    `version` INT NOT NULL COMMENT '版本号',
    `system_prompt` TEXT NOT NULL COMMENT '该版本的系统提示词',
    `operator` VARCHAR(64) DEFAULT NULL COMMENT '操作人',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    KEY `idx_agent_code` (`agent_code`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'AI Agent提示词版本历史表';

-- 模型厂商配置表（可切换 Claude/GPT/Qwen 等）
CREATE TABLE IF NOT EXISTS `t_ai_model_provider` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `provider_name` VARCHAR(64) NOT NULL COMMENT '厂商名称 如:中转站-Claude/硅基流动-Qwen',
    `base_url` VARCHAR(256) NOT NULL COMMENT 'API地址(OpenAI兼容协议)',
    `api_key` VARCHAR(512) NOT NULL COMMENT 'API密钥(AES加密存储,加密密钥走环境变量)',
    `chat_model` VARCHAR(64) DEFAULT NULL COMMENT '对话模型 如 claude-sonnet-4-6 / Qwen/Qwen3-8B',
    `embedding_model` VARCHAR(64) DEFAULT NULL COMMENT 'Embedding模型 如 BAAI/bge-m3',
    `is_default` TINYINT NOT NULL DEFAULT 0 COMMENT '默认对话厂商 1=是 0=否',
    `is_default_embedding` TINYINT NOT NULL DEFAULT 0 COMMENT '默认Embedding厂商 1=是 0=否',
    `enabled` TINYINT NOT NULL DEFAULT 1 COMMENT '启用状态 1=启用 0=停用',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'AI模型厂商配置表';

-- 知识库同步日志表
CREATE TABLE IF NOT EXISTS `t_ai_kb_sync_log` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `kb_type` VARCHAR(16) NOT NULL COMMENT '知识库类型 PRODUCT=商品 FAQ=常见问题',
    `sync_type` VARCHAR(16) NOT NULL COMMENT '同步类型 INCREMENT=增量 FULL=全量重建',
    `doc_count` INT NOT NULL DEFAULT 0 COMMENT '本次同步文档数',
    `cost_ms` BIGINT DEFAULT NULL COMMENT '耗时(毫秒)',
    `status` VARCHAR(16) NOT NULL DEFAULT 'RUNNING' COMMENT '状态 RUNNING=进行中 SUCCESS=成功 FAILED=失败',
    `error_msg` VARCHAR(1000) DEFAULT NULL COMMENT '失败原因',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_kb_type` (`kb_type`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'AI知识库同步日志表';

-- AI 通用设置表（key-value，如每日限额，B端可改热生效）
CREATE TABLE IF NOT EXISTS `t_ai_setting` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `setting_key` VARCHAR(64) NOT NULL COMMENT '设置项键',
    `setting_value` VARCHAR(256) NOT NULL COMMENT '设置项值',
    `remark` VARCHAR(256) DEFAULT NULL COMMENT '说明',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_setting_key` (`setting_key`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = 'AI通用设置表';

-- 种子数据：每日限额
INSERT INTO `t_ai_setting` (`setting_key`, `setting_value`, `remark`) VALUES
('daily_quota_user', '50', '登录用户每日消息条数上限'),
('daily_quota_guest', '10', '游客每日消息条数上限')
ON DUPLICATE KEY UPDATE `setting_key` = `setting_key`;

-- 种子数据：Agent 初始配置（提示词为占位初版，P1/P2 实施时按客服-agent 框架精修，B端可随时编辑）
INSERT INTO `t_ai_agent_config` (`agent_code`, `agent_name`, `system_prompt`, `temperature`) VALUES
('COORDINATOR', '意图路由', '你是电商平台 ai-mall 的意图分类器。根据用户消息与最近对话上下文，将本轮意图分类为以下之一并只输出该编码：SHOPPING_GUIDE（咨询/挑选/推荐商品）、CUSTOMER_SERVICE（平台政策/使用问题/订单查询咨询）、AFTER_SALES（退换货/维修/投诉等售后诉求）。只输出编码，不输出任何其他内容。', 0.00),
('SHOPPING_GUIDE', '导购助手', '你是 ai-mall 商城的导购助手。根据用户需求与提供的参考商品资料进行推荐：共情开场，分层推荐（每层给出层级说明），只推荐参考资料中出现的商品并给出 spuId，最后总结并给出 2-3 个快捷追问。不得编造价格与库存。', 0.70),
('CUSTOMER_SERVICE', '客服助手', '你是 ai-mall 商城的客服助手。仅根据提供的 FAQ 参考资料回答用户问题，资料未覆盖时如实告知并建议联系人工客服。回答简洁友好，附带引用的 FAQ 标题。', 0.30),
('AFTER_SALES', '售后助手', '你是 ai-mall 商城的售后助手。倾听用户售后诉求，结合订单信息与工单分类进行归类，输出结构化归类结果（工单分类/问题描述/关联订单）供用户确认。未经用户确认不得创建工单。', 0.30)
ON DUPLICATE KEY UPDATE `agent_code` = `agent_code`;
