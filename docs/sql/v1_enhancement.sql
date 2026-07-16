-- v1 增强迭代：商品评价 + 收藏/心愿单
-- 执行方式：mysql -u<user> -p ai_mall < v1_enhancement.sql

-- 商品评价表
CREATE TABLE IF NOT EXISTS `t_product_review` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '评价ID',
    `order_id` BIGINT NOT NULL COMMENT '订单ID',
    `order_item_id` BIGINT NOT NULL COMMENT '订单项ID',
    `spu_id` BIGINT NOT NULL COMMENT 'SPU ID',
    `sku_id` BIGINT NOT NULL COMMENT 'SKU ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `rating` TINYINT NOT NULL COMMENT '评分 1-5',
    `content` VARCHAR(1000) DEFAULT NULL COMMENT '评价内容',
    `images` JSON DEFAULT NULL COMMENT '晒图URL数组',
    `sku_spec` VARCHAR(500) DEFAULT NULL COMMENT '规格快照',
    `status` TINYINT NOT NULL DEFAULT 1 COMMENT '状态 1=显示 0=隐藏',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_order_item` (`order_item_id`),
    KEY `idx_spu_id` (`spu_id`),
    KEY `idx_user_id` (`user_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '商品评价表';

-- 收藏/心愿单表（关联 spu_id，B端编辑商品会重建SKU，不可存 sku_id）
CREATE TABLE IF NOT EXISTS `t_favorite` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `spu_id` BIGINT NOT NULL COMMENT 'SPU ID',
    `create_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_user_spu` (`user_id`, `spu_id`),
    KEY `idx_spu_id` (`spu_id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COMMENT = '收藏/心愿单表';
