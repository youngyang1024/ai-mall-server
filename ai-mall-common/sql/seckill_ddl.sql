-- Flash Sale 导入配套 DDL（若已执行过可跳过）
-- 1) 确保商品描述支持富文本
ALTER TABLE `t_spu` MODIFY COLUMN `description` LONGTEXT COMMENT '商品详情描述(富文本)';

-- 2) 可选：图片 URL 若超长可扩容（本批脚本已截断到 256）
-- ALTER TABLE `t_spu` MODIFY COLUMN `main_image` VARCHAR(512) DEFAULT NULL COMMENT '主图URL';
-- ALTER TABLE `t_spu_image` MODIFY COLUMN `image_url` VARCHAR(512) NOT NULL COMMENT '图片URL';
