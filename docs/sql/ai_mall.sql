/*
 Navicat Premium Dump SQL

 Source Server         : 用增-开发环境
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : mysql.infra.dev.ug:3306
 Source Schema         : ai_mall

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 10/11/2026 13:08:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_admin
-- ----------------------------
DROP TABLE IF EXISTS `t_admin`;
CREATE TABLE `t_admin` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(64) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码(BCrypt)',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1=启用 0=禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='管理员表';

-- ----------------------------
-- Records of t_admin
-- ----------------------------
BEGIN;
INSERT INTO `t_admin` (`id`, `username`, `password`, `nickname`, `status`, `create_time`, `update_time`) VALUES (1, 'admin', '$2b$10$GyBqcawgTI2YewgRzNYGJOoRiqlSSdOS1bxRCICiTU6xzHgpBctMa', '超级管理员', 1, '2026-07-13 10:22:42', '2026-07-13 10:22:42');
COMMIT;

-- ----------------------------
-- Table structure for t_banner
-- ----------------------------
DROP TABLE IF EXISTS `t_banner`;
CREATE TABLE `t_banner` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(128) DEFAULT NULL COMMENT '标题',
  `image_url` varchar(256) NOT NULL COMMENT '图片URL',
  `link_url` varchar(256) DEFAULT NULL COMMENT '跳转链接',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1=启用 0=禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='轮播图表';

-- ----------------------------
-- Records of t_banner
-- ----------------------------
BEGIN;
INSERT INTO `t_banner` (`id`, `title`, `image_url`, `link_url`, `sort`, `status`, `create_time`) VALUES (1, '家具焕新季', 'https://img5.su-cdn.com/cdn-cgi/image/format=webp/ad/2025/10/10/3840x1920_761f5c8a51bb32df76fa23f978f8be84.jpg', '/', 1, 1, '2026-07-13 13:59:42');
INSERT INTO `t_banner` (`id`, `title`, `image_url`, `link_url`, `sort`, `status`, `create_time`) VALUES (2, '户外庭院精选', 'https://img5.su-cdn.com/cdn-cgi/image/format=webp/ad/2026/06/22/3840x1920_ac197e918446fc05aa36cc7f0da1ca17.jpg', '/category', 2, 1, '2026-07-13 13:59:42');
INSERT INTO `t_banner` (`id`, `title`, `image_url`, `link_url`, `sort`, `status`, `create_time`) VALUES (3, '卫浴五金热卖', 'https://img5.su-cdn.com/cdn-cgi/image/format=webp/ad/2025/10/10/2880x1440_37e76510e8bb2711fc1bf4176d5eb7f7.png', '/category', 3, 1, '2026-07-13 13:59:42');
COMMIT;

-- ----------------------------
-- Table structure for t_cart
-- ----------------------------
DROP TABLE IF EXISTS `t_cart`;
CREATE TABLE `t_cart` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `sku_id` bigint NOT NULL COMMENT 'SKU ID',
  `quantity` int NOT NULL DEFAULT '1' COMMENT '数量',
  `checked` tinyint NOT NULL DEFAULT '1' COMMENT '1=选中 0=未选中',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_sku` (`user_id`,`sku_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='购物车表';

-- ----------------------------
-- Records of t_cart
-- ----------------------------
BEGIN;
INSERT INTO `t_cart` (`id`, `user_id`, `sku_id`, `quantity`, `checked`, `create_time`, `update_time`) VALUES (13, 1, 159, 1, 0, '2026-07-16 20:10:15', '2026-07-16 20:14:24');
INSERT INTO `t_cart` (`id`, `user_id`, `sku_id`, `quantity`, `checked`, `create_time`, `update_time`) VALUES (14, 1, 162, 2, 1, '2026-07-16 20:23:30', '2026-07-16 20:23:32');
COMMIT;

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '分类名称',
  `parent_id` bigint NOT NULL DEFAULT '0' COMMENT '父分类ID，0=顶级',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序值',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1=启用 0=禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品分类表';

-- ----------------------------
-- Records of t_category
-- ----------------------------
BEGIN;
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (1, '家具', 0, 1, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (2, '户外', 0, 2, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (3, '卫浴五金', 0, 3, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (4, '灯具', 0, 4, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (5, '厨房', 0, 5, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (6, '装饰地毯', 0, 6, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (11, '客厅家具', 1, 1, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (12, '沙发组合', 1, 2, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (13, '餐桌椅', 1, 3, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (14, '卧室家具', 1, 4, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (15, '茶几', 1, 5, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (16, '休闲椅', 1, 6, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (17, '书桌', 1, 7, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (18, '电视柜', 1, 8, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (19, '吧台凳', 1, 9, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (21, '户外家具', 2, 1, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (22, '户外沙发', 2, 2, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (23, '户外餐桌', 2, 3, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (24, '庭院遮阳', 2, 4, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (31, '浴室柜', 3, 1, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (32, '水龙头', 3, 2, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (33, '花洒', 3, 3, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (34, '浴室镜', 3, 4, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (41, '吸顶灯', 4, 1, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (42, '吊灯', 4, 2, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (43, '壁灯', 4, 3, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (44, '台灯落地灯', 4, 4, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (51, '厨房龙头', 5, 1, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (52, '水槽', 5, 2, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (53, '厨房岛台', 5, 3, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (61, '地毯', 6, 1, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (62, '墙镜', 6, 2, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (63, '墙面装饰', 6, 3, 1, '2026-07-13 13:59:42');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (64, '庄园', 0, 0, 1, '2026-07-14 14:39:21');
INSERT INTO `t_category` (`id`, `name`, `parent_id`, `sort`, `status`, `create_time`) VALUES (65, '卫浴', 0, 0, 1, '2026-07-14 14:39:56');
COMMIT;

-- ----------------------------
-- Table structure for t_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_coupon`;
CREATE TABLE `t_coupon` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL COMMENT '券名称',
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '1=满减券',
  `threshold` decimal(10,2) NOT NULL COMMENT '满减门槛',
  `discount` decimal(10,2) NOT NULL COMMENT '减免金额',
  `total_count` int NOT NULL COMMENT '发放总量',
  `received_count` int NOT NULL DEFAULT '0' COMMENT '已领取数',
  `start_time` datetime NOT NULL COMMENT '有效期开始',
  `end_time` datetime NOT NULL COMMENT '有效期结束',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1=启用 0=停用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='优惠券模板表';

-- ----------------------------
-- Records of t_coupon
-- ----------------------------
BEGIN;
INSERT INTO `t_coupon` (`id`, `name`, `type`, `threshold`, `discount`, `total_count`, `received_count`, `start_time`, `end_time`, `status`, `create_time`) VALUES (1, '满100-50', 1, 100.00, 50.00, 1000, 4, '2026-07-01 00:00:00', '2026-07-31 23:59:59', 1, '2026-07-14 10:48:19');
COMMIT;

-- ----------------------------
-- Table structure for t_faq_article
-- ----------------------------
DROP TABLE IF EXISTS `t_faq_article`;
CREATE TABLE `t_faq_article` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `title` varchar(255) NOT NULL COMMENT '问题标题',
  `content` text NOT NULL COMMENT '问答内容',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '状态(0:禁用 1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='FAQ文章表';

-- ----------------------------
-- Records of t_faq_article
-- ----------------------------
BEGIN;
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 5, '优惠券使用指南', '<p>可以在结账时输入您的优惠券代码。如果优惠券无效，请检查是否过期或是否满足最低消费要求。</p>', 1, 1, '2026-07-14 14:29:01', '2026-07-16 20:11:54');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 3, '我可以换货吗？', '<p>我们支持30天无理由退换货，请在订单详情页申请换货。</p>', 2, 1, '2026-07-14 14:29:01', '2026-07-16 20:11:59');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 1, '如何申请商业账户？', '<p>请访问我们的商业合作页面并填写申请表，我们的团队将在24小时内联系您。</p>', 3, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:17');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 4, '大件商品运送说明', '<p>大件商品将通过专线物流配送，送货前承运商会与您电话预约时间。</p>', 4, 1, '2026-07-14 14:29:01', '2026-07-16 20:12:15');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 2, '产品是否有保修？', '<p>是的，我们的大部分产品提供1-3年的有限保修。</p>', 1, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:24');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (6, 2, '有实体店可以参观吗？', '<p>目前我们主要在线上运营，以此为您提供最具性价比的商品，暂无实体展厅。</p>', 2, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:26');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (7, 3, '30天退货政策', '<p>如果您对购买的商品不满意，可以在收到商品后30天内申请退货。</p>', 1, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:28');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (8, 3, '退款需要多长时间？', '<p>退款通常在收到退回商品后的3-5个工作日内原路退回到您的支付账户。</p>', 2, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:31');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (9, 4, '运费怎么计算？', '<p>我们为绝大多数订单提供免邮服务，偏远地区可能会收取少量偏远附加费。</p>', 1, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:32');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (10, 4, '我可以更改收货地址吗？', '<p>在订单发货前，您可以联系客服修改收货地址；一旦发货则无法修改。</p>', 2, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:34');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (11, 5, '支持哪些支付方式？', '<p>我们支持支付宝、微信支付、信用卡及PayPal等多种支付方式。</p>', 1, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:37');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (12, 6, '如何修改或取消订单？', '<p>在订单未发货前，您可以随时在\"我的订单\"页面中取消或修改。</p>', 1, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:39');
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`, `create_time`, `update_time`) VALUES (13, 6, '订单状态术语说明', '<p>待支付、处理中、已发货、已完成等状态代表了您订单的当前进度。</p>', 2, 1, '2026-07-14 14:29:01', '2026-07-14 14:32:40');
COMMIT;

-- ----------------------------
-- Table structure for t_faq_category
-- ----------------------------
DROP TABLE IF EXISTS `t_faq_category`;
CREATE TABLE `t_faq_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(100) NOT NULL COMMENT '分类名称',
  `sort` int DEFAULT '0' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '状态(0:禁用 1:启用)',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='FAQ分类表';

-- ----------------------------
-- Records of t_faq_category
-- ----------------------------
BEGIN;
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, '商务合作', 7, 1, '2026-07-14 14:29:01', '2026-07-16 20:12:55');
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, '产品常见问题 ', 2, 1, '2026-07-14 14:29:01', '2026-07-14 14:33:06');
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, '退换货 ', 3, 1, '2026-07-14 14:29:01', '2026-07-14 14:33:08');
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, '配送与发货', 4, 1, '2026-07-14 14:29:01', '2026-07-14 14:33:09');
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, '支付与价格', 5, 1, '2026-07-14 14:29:01', '2026-07-14 14:33:10');
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (6, '订单', 6, 1, '2026-07-14 14:29:01', '2026-07-14 14:33:12');
COMMIT;

-- ----------------------------
-- Table structure for t_favorite
-- ----------------------------
DROP TABLE IF EXISTS `t_favorite`;
CREATE TABLE `t_favorite` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `spu_id` bigint NOT NULL COMMENT 'SPU ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_spu` (`user_id`,`spu_id`),
  KEY `idx_spu_id` (`spu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='收藏/心愿单表';

-- ----------------------------
-- Records of t_favorite
-- ----------------------------
BEGIN;
INSERT INTO `t_favorite` (`id`, `user_id`, `spu_id`, `create_time`) VALUES (1, 1, 100, '2026-07-16 20:09:55');
COMMIT;

-- ----------------------------
-- Table structure for t_hot_search
-- ----------------------------
DROP TABLE IF EXISTS `t_hot_search`;
CREATE TABLE `t_hot_search` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `keyword` varchar(100) NOT NULL COMMENT '搜索关键词',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否带有火热图标(0-否 1-是)',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序(越小越靠前)',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态(0-禁用 1-启用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='热门搜索词表';

-- ----------------------------
-- Records of t_hot_search
-- ----------------------------
BEGIN;
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, '布艺沙发', 1, 1, 1, '2026-07-14 10:30:47', '2026-07-14 10:30:47');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, '实木餐桌', 1, 2, 1, '2026-07-14 10:30:47', '2026-07-14 10:30:47');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, '极简茶几', 1, 3, 1, '2026-07-14 10:30:47', '2026-07-14 10:30:47');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, '北欧风吊灯', 0, 4, 1, '2026-07-14 10:30:47', '2026-07-14 10:30:47');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, '真皮单椅', 0, 5, 1, '2026-07-14 10:30:47', '2026-07-14 10:30:47');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (6, '户外折叠椅', 0, 6, 1, '2026-07-14 10:30:47', '2026-07-14 10:30:47');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (7, '智能马桶', 0, 7, 1, '2026-07-14 10:30:47', '2026-07-14 10:30:47');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (8, '浴室柜', 0, 8, 1, '2026-07-14 10:30:47', '2026-07-14 10:30:47');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (9, '茶歇吧台', 1, 0, 1, '2026-07-14 14:40:53', '2026-07-14 14:40:53');
INSERT INTO `t_hot_search` (`id`, `keyword`, `is_hot`, `sort`, `status`, `create_time`, `update_time`) VALUES (10, '烧烤炉', 1, 0, 1, '2026-07-14 14:41:14', '2026-07-14 14:41:14');
COMMIT;

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_no` varchar(32) NOT NULL COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `total_amount` decimal(10,2) NOT NULL COMMENT '商品总额',
  `discount_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠金额',
  `pay_amount` decimal(10,2) NOT NULL COMMENT '实付金额',
  `coupon_id` bigint DEFAULT NULL COMMENT '使用的用户券ID',
  `status` tinyint NOT NULL COMMENT '订单状态',
  `receiver_info` varchar(512) NOT NULL COMMENT '收货信息JSON快照',
  `remark` varchar(256) DEFAULT NULL COMMENT '买家备注',
  `logistics_no` varchar(64) DEFAULT NULL COMMENT '物流单号',
  `pay_time` datetime DEFAULT NULL COMMENT '支付时间',
  `ship_time` datetime DEFAULT NULL COMMENT '发货时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_no` (`order_no`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_status` (`status`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单表';

-- ----------------------------
-- Records of t_order
-- ----------------------------
BEGIN;
INSERT INTO `t_order` (`id`, `order_no`, `user_id`, `total_amount`, `discount_amount`, `pay_amount`, `coupon_id`, `status`, `receiver_info`, `remark`, `logistics_no`, `pay_time`, `ship_time`, `finish_time`, `create_time`, `update_time`) VALUES (1, 'ORD17839937112946730', 1, 219.99, 0.00, 219.99, NULL, 1, '{\"receiverName\":\"111111111\",\"receiverPhone\":\"1111\",\"province\":\"111\",\"city\":\"111\",\"district\":\"111\",\"detail\":\"111\"}', '', NULL, '2026-07-14 09:48:33', NULL, NULL, '2026-07-14 09:48:31', '2026-07-14 09:48:33');
INSERT INTO `t_order` (`id`, `order_no`, `user_id`, `total_amount`, `discount_amount`, `pay_amount`, `coupon_id`, `status`, `receiver_info`, `remark`, `logistics_no`, `pay_time`, `ship_time`, `finish_time`, `create_time`, `update_time`) VALUES (2, 'ORD17839945945222317', 1, 569.99, 0.00, 569.99, NULL, 6, '{\"receiverName\":\"1111\",\"receiverPhone\":\"11\",\"province\":\"广东省\",\"city\":\"深圳市\",\"district\":\"宝安区\",\"detail\":\"111\"}', '', NULL, '2026-07-14 10:03:17', NULL, NULL, '2026-07-14 10:03:14', '2026-07-14 11:33:45');
INSERT INTO `t_order` (`id`, `order_no`, `user_id`, `total_amount`, `discount_amount`, `pay_amount`, `coupon_id`, `status`, `receiver_info`, `remark`, `logistics_no`, `pay_time`, `ship_time`, `finish_time`, `create_time`, `update_time`) VALUES (3, 'ORD17839991465492317', 1, 589.98, 50.00, 539.98, 1, 3, '{\"receiverName\":\"1111\",\"receiverPhone\":\"11\",\"province\":\"广东省\",\"city\":\"深圳市\",\"district\":\"宝安区\",\"detail\":\"111\"}', '', '123456', '2026-07-14 11:19:08', '2026-07-14 11:19:27', '2026-07-14 11:19:41', '2026-07-14 11:19:06', '2026-07-14 11:19:41');
INSERT INTO `t_order` (`id`, `order_no`, `user_id`, `total_amount`, `discount_amount`, `pay_amount`, `coupon_id`, `status`, `receiver_info`, `remark`, `logistics_no`, `pay_time`, `ship_time`, `finish_time`, `create_time`, `update_time`) VALUES (4, 'ORD17841951498658868', 1, 4798.96, 50.00, 4748.96, 4, 1, '{\"receiverName\":\"222\",\"receiverPhone\":\"222\",\"province\":\"广东省\",\"city\":\"珠海市\",\"district\":\"香洲区\",\"detail\":\"222\"}', '', NULL, '2026-07-16 17:45:52', NULL, NULL, '2026-07-16 17:45:50', '2026-07-16 17:45:52');
INSERT INTO `t_order` (`id`, `order_no`, `user_id`, `total_amount`, `discount_amount`, `pay_amount`, `coupon_id`, `status`, `receiver_info`, `remark`, `logistics_no`, `pay_time`, `ship_time`, `finish_time`, `create_time`, `update_time`) VALUES (5, 'ORD17842051985532583', 1, 2245.98, 0.00, 2245.98, NULL, 1, '{\"receiverName\":\"222\",\"receiverPhone\":\"222\",\"province\":\"广东省\",\"city\":\"珠海市\",\"district\":\"香洲区\",\"detail\":\"222\"}', '', NULL, '2026-07-16 20:33:19', NULL, NULL, '2026-07-16 20:33:18', '2026-07-16 20:33:19');
COMMIT;

-- ----------------------------
-- Table structure for t_order_item
-- ----------------------------
DROP TABLE IF EXISTS `t_order_item`;
CREATE TABLE `t_order_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `spu_id` bigint NOT NULL COMMENT 'SPU ID',
  `sku_id` bigint NOT NULL COMMENT 'SKU ID',
  `spu_name` varchar(128) DEFAULT NULL COMMENT '商品名称快照',
  `sku_spec` varchar(256) DEFAULT NULL COMMENT '规格快照',
  `image` varchar(256) DEFAULT NULL COMMENT '商品图片快照',
  `price` decimal(10,2) NOT NULL COMMENT '成交单价',
  `quantity` int NOT NULL COMMENT '购买数量',
  PRIMARY KEY (`id`),
  KEY `idx_order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单明细表';

-- ----------------------------
-- Records of t_order_item
-- ----------------------------
BEGIN;
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (1, 1, 55, 55, '15.7\" 黑色 4-抽屉 浴室 柜子 带 壁挂式 or Floor-st与g', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/07/31/2500x2500_6bbd99a408bab353919c6f4737bf6462.jpg', 219.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (2, 2, 4, 4, 'Aro 59\" 落地式 浴室 储物 柜子 带 层架, 抽屉 & 门', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fbf22777ba8014774a7d61221af4cb212_.jpg', 569.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (3, 3, 60, 60, '浴室柜 套装 27.9\" 现代 悬浮 陶瓷 浴室柜 黑色 带水槽', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/22/2500x2500_92f82fbba644c5b9732aaf02e0757e5f.jpg', 479.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (4, 3, 92, 92, '30寸户外家具款', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/10/24/f81de2732e038c7a0c4add9b5c7a2a2d.jpg', 109.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (5, 4, 100, 110, '浴室柜 套装 31.5\" 现代 悬浮 浴室柜 带水槽', '{\"颜色\":\"红\",\"尺码\":\"S\"}', '', 99.00, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (6, 4, 55, 55, '15.7\" 黑色 4-抽屉 浴室 柜子 带 壁挂式 or Floor-st与g', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/07/31/2500x2500_6bbd99a408bab353919c6f4737bf6462.jpg', 219.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (7, 4, 2037, 155, '37\"客厅家具款', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_dbc3adebd57965e5786c055992c93722.jpg', 569.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (8, 4, 2028, 146, '铝制餐桌椅款', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_ea17eff6265eef031a9e744b59401d72.jpg', 3029.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (9, 4, 47, 47, 'Airloo 智能 Bidet Toilet 带 Built- Tank, UV Sterilization 与 Foam Shield, Dual Flush 1.1/1.6 GPF', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/04/23/2500x2500_9018865b20885a317875b2c28f11de1c.jpg', 879.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (10, 5, 2037, 155, '37\"客厅家具款', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_dbc3adebd57965e5786c055992c93722.jpg', 569.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (11, 5, 2038, 156, '118\"庭院遮阳款', '{\"颜色\": \"默认款\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_946e42f9a119f2110178e6839060786a.jpg', 1279.99, 1);
INSERT INTO `t_order_item` (`id`, `order_id`, `spu_id`, `sku_id`, `spu_name`, `sku_spec`, `image`, `price`, `quantity`) VALUES (12, 5, 100, 110, '浴室柜 套装 31.5\" 现代 悬浮 浴室柜 带水槽', '{\"颜色\":\"红\",\"尺码\":\"S\"}', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/05/21/2500x2500_eb75b5a609a45e2c5a715d1547a0002a.jpg', 99.00, 4);
COMMIT;

-- ----------------------------
-- Table structure for t_product_review
-- ----------------------------
DROP TABLE IF EXISTS `t_product_review`;
CREATE TABLE `t_product_review` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `order_item_id` bigint NOT NULL COMMENT '订单项ID',
  `spu_id` bigint NOT NULL COMMENT 'SPU ID',
  `sku_id` bigint NOT NULL COMMENT 'SKU ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `rating` tinyint NOT NULL COMMENT '评分 1-5',
  `content` varchar(1000) DEFAULT NULL COMMENT '评价内容',
  `images` json DEFAULT NULL COMMENT '晒图URL数组',
  `sku_spec` varchar(500) DEFAULT NULL COMMENT '规格快照',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 1=显示 0=隐藏',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_order_item` (`order_item_id`),
  KEY `idx_spu_id` (`spu_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品评价表';

-- ----------------------------
-- Records of t_product_review
-- ----------------------------
BEGIN;
INSERT INTO `t_product_review` (`id`, `order_id`, `order_item_id`, `spu_id`, `sku_id`, `user_id`, `rating`, `content`, `images`, `sku_spec`, `status`, `create_time`, `update_time`) VALUES (1, 3, 4, 92, 92, 1, 5, '非常棒', '[\"https://media-local-s3.s3.us-east-1.amazonaws.com/growth/dev/review/2026/07/16/48a4d195136c4dedadfa1f87c0608785.png\"]', '{\"颜色\": \"默认款\"}', 1, '2026-07-16 20:28:59', '2026-07-16 20:28:59');
COMMIT;

-- ----------------------------
-- Table structure for t_refund
-- ----------------------------
DROP TABLE IF EXISTS `t_refund`;
CREATE TABLE `t_refund` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `refund_no` varchar(32) NOT NULL COMMENT '退款单号',
  `order_id` bigint NOT NULL COMMENT '关联订单',
  `user_id` bigint NOT NULL COMMENT '申请用户',
  `refund_amount` decimal(10,2) NOT NULL COMMENT '退款金额',
  `reason` varchar(256) NOT NULL COMMENT '退款原因',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0=待审核 1=已通过 2=已拒绝',
  `order_status_before` tinyint NOT NULL COMMENT '申请前订单状态',
  `reject_reason` varchar(256) DEFAULT NULL COMMENT '拒绝原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_refund_no` (`refund_no`),
  KEY `idx_order_id` (`order_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='退款申请表';

-- ----------------------------
-- Records of t_refund
-- ----------------------------
BEGIN;
INSERT INTO `t_refund` (`id`, `refund_no`, `order_id`, `user_id`, `refund_amount`, `reason`, `status`, `order_status_before`, `reject_reason`, `create_time`, `update_time`) VALUES (1, 'REF17839996205182286', 2, 1, 569.99, '2', 1, 1, NULL, '2026-07-14 11:27:01', '2026-07-14 11:33:45');
COMMIT;

-- ----------------------------
-- Table structure for t_service_category
-- ----------------------------
DROP TABLE IF EXISTS `t_service_category`;
CREATE TABLE `t_service_category` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(64) NOT NULL COMMENT '分类编码',
  `name` varchar(64) NOT NULL COMMENT '分类名称',
  `icon` varchar(64) DEFAULT NULL COMMENT '图标名',
  `need_order_no` tinyint NOT NULL DEFAULT '0' COMMENT '是否需要订单号 0否 1是',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 0禁用 1启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_service_category_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务中心问题大类表';

-- ----------------------------
-- Records of t_service_category
-- ----------------------------
BEGIN;
INSERT INTO `t_service_category` (`id`, `code`, `name`, `icon`, `need_order_no`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 'RETURN_REFUND', '退货与退款', 'revoke', 1, 1, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_category` (`id`, `code`, `name`, `icon`, `need_order_no`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 'SHIPPING_DELIVERY', '运输与交付', 'logistics', 1, 2, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_category` (`id`, `code`, `name`, `icon`, `need_order_no`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 'PRODUCT_SUPPORT', '产品支持', 'setting-o', 1, 3, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_category` (`id`, `code`, `name`, `icon`, `need_order_no`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 'ACCOUNT_PAYMENT', '账户与支付', 'balance-pay', 1, 4, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_category` (`id`, `code`, `name`, `icon`, `need_order_no`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 'SUGGESTION_FEEDBACK', '建议与反馈', 'chat-o', 0, 5, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
COMMIT;

-- ----------------------------
-- Table structure for t_service_issue
-- ----------------------------
DROP TABLE IF EXISTS `t_service_issue`;
CREATE TABLE `t_service_issue` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint NOT NULL COMMENT '服务大类ID',
  `code` varchar(64) NOT NULL COMMENT '问题编码',
  `name` varchar(128) NOT NULL COMMENT '问题名称',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '状态 0禁用 1启用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_service_issue_code` (`code`),
  KEY `idx_service_issue_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务中心问题小类表';

-- ----------------------------
-- Records of t_service_issue
-- ----------------------------
BEGIN;
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (1, 1, 'RETURN_DONT_WANT', '只是/不喜欢它/无法接受它', 1, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (2, 1, 'RETURN_NOT_DESCRIBED', '并不像所描述的那样', 2, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (3, 1, 'RETURN_NOT_WORKING', '无法使用/出现故障', 3, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (4, 1, 'RETURN_DAMAGED', '送达时损坏了', 4, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (5, 1, 'RETURN_NOT_INTENDED', '并未达到预期效果', 5, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (6, 1, 'RETURN_WRONG_ITEM', '送错了商品', 6, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (7, 2, 'SHIP_TRACKING_NEEDED', '需要跟踪信息', 1, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (8, 2, 'SHIP_TRACKING_INVALID', '跟踪信息无效', 2, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (9, 2, 'SHIP_TRACKING_NOT_UPDATED', '跟踪信息未更新', 3, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (10, 2, 'SHIP_PACKAGE_DAMAGED', '包裹在运输过程中受到损坏', 4, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (11, 2, 'SHIP_CUSTOMS', '海关清关', 5, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (12, 2, 'SHIP_DELIVERED_NOT_RECEIVED', '显示已交付，但并未收到货物', 6, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (13, 3, 'SUPPORT_INSTALLATION', '产品安装指导', 1, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (14, 3, 'SUPPORT_USAGE', '产品使用咨询', 2, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (15, 3, 'SUPPORT_PARTS', '零部件补发', 3, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (16, 3, 'SUPPORT_MANUAL', '说明书/视频资料', 4, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (17, 3, 'SUPPORT_WARRANTY', '保修与维护', 5, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (18, 3, 'SUPPORT_TROUBLESHOOT', '功能故障排查', 6, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (19, 4, 'ACCOUNT_REGISTER', '注册', 1, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (20, 4, 'ACCOUNT_PASSWORD', '更改登录密码', 2, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (21, 4, 'ACCOUNT_ORDER_CANCEL', '订单/取消订单', 3, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (22, 4, 'ACCOUNT_INFO', '高级账户信息', 4, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (23, 4, 'ACCOUNT_PAY_FAILED', '无法进行支付', 5, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (24, 4, 'ACCOUNT_PAY_STATUS', '确认支付状态', 6, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (25, 5, 'FEEDBACK_SHIPPING', '运输改进', 1, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (26, 5, 'FEEDBACK_PRODUCT', '产品反馈', 2, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (27, 5, 'FEEDBACK_WEBSITE', '网站出现故障', 3, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
INSERT INTO `t_service_issue` (`id`, `category_id`, `code`, `name`, `sort`, `status`, `create_time`, `update_time`) VALUES (28, 5, 'FEEDBACK_SERVICE', '客户服务', 4, 1, '2026-07-15 17:27:47', '2026-07-15 17:27:47');
COMMIT;

-- ----------------------------
-- Table structure for t_service_ticket
-- ----------------------------
DROP TABLE IF EXISTS `t_service_ticket`;
CREATE TABLE `t_service_ticket` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_no` varchar(32) NOT NULL COMMENT '工单编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `category_id` bigint NOT NULL COMMENT '大类ID',
  `category_name` varchar(64) NOT NULL COMMENT '大类名称',
  `issue_id` bigint NOT NULL COMMENT '小类ID',
  `issue_name` varchar(128) NOT NULL COMMENT '小类名称',
  `order_no` varchar(32) DEFAULT NULL COMMENT '订单号',
  `content` text NOT NULL COMMENT '工单首条描述',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态 0待处理 1处理中 2已完成',
  `contact_first_name` varchar(64) NOT NULL COMMENT '联系人名',
  `contact_last_name` varchar(64) NOT NULL COMMENT '联系人姓',
  `contact_email` varchar(128) NOT NULL COMMENT '联系人邮箱',
  `contact_area_code` varchar(16) DEFAULT NULL COMMENT '电话区号',
  `contact_phone` varchar(32) NOT NULL COMMENT '联系电话',
  `last_reply_user_type` tinyint NOT NULL DEFAULT '1' COMMENT '最后回复人类型 1用户 2管理员',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_service_ticket_no` (`ticket_no`),
  KEY `idx_service_ticket_user_id` (`user_id`),
  KEY `idx_service_ticket_status` (`status`),
  KEY `idx_service_ticket_order_no` (`order_no`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务工单主表';

-- ----------------------------
-- Records of t_service_ticket
-- ----------------------------
BEGIN;
INSERT INTO `t_service_ticket` (`id`, `ticket_no`, `user_id`, `category_id`, `category_name`, `issue_id`, `issue_name`, `order_no`, `content`, `status`, `contact_first_name`, `contact_last_name`, `contact_email`, `contact_area_code`, `contact_phone`, `last_reply_user_type`, `create_time`, `update_time`) VALUES (1, 'ST202607151738346117', 1, 1, '退货与退款', 2, '并不像所描述的那样', '#ORD17839991465492317', '质量有问题', 2, '三', '张', '112123@aa.com', '+86', '11111111111', 2, '2026-07-15 17:38:34', '2026-07-15 18:10:18');
COMMIT;

-- ----------------------------
-- Table structure for t_service_ticket_attachment
-- ----------------------------
DROP TABLE IF EXISTS `t_service_ticket_attachment`;
CREATE TABLE `t_service_ticket_attachment` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_id` bigint NOT NULL COMMENT '工单ID',
  `reply_id` bigint NOT NULL COMMENT '回复ID',
  `user_type` tinyint NOT NULL COMMENT '上传人类型 1用户 2管理员',
  `file_name` varchar(128) NOT NULL COMMENT '文件名',
  `file_url` varchar(512) NOT NULL COMMENT '文件地址',
  `file_type` varchar(32) NOT NULL COMMENT '文件类型',
  `file_size` bigint NOT NULL DEFAULT '0' COMMENT '文件大小字节',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_service_ticket_attachment_ticket_id` (`ticket_id`),
  KEY `idx_service_ticket_attachment_reply_id` (`reply_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务工单附件表';

-- ----------------------------
-- Records of t_service_ticket_attachment
-- ----------------------------
BEGIN;
INSERT INTO `t_service_ticket_attachment` (`id`, `ticket_id`, `reply_id`, `user_type`, `file_name`, `file_url`, `file_type`, `file_size`, `create_time`) VALUES (1, 1, 1, 1, 'e75bd6c8e3f74477b3769eec6fe5c2ce.png', 'https://media-local-s3.s3.us-east-1.amazonaws.com/growth/dev/2026/07/15/e75bd6c8e3f74477b3769eec6fe5c2ce.png', 'png', 0, '2026-07-15 17:38:34');
INSERT INTO `t_service_ticket_attachment` (`id`, `ticket_id`, `reply_id`, `user_type`, `file_name`, `file_url`, `file_type`, `file_size`, `create_time`) VALUES (2, 1, 3, 2, '6f46a345f92f492c8b7567c01474fee2.png', 'https://media-local-s3.s3.us-east-1.amazonaws.com/growth/dev/2026/07/15/6f46a345f92f492c8b7567c01474fee2.png', 'png', 0, '2026-07-15 17:41:28');
COMMIT;

-- ----------------------------
-- Table structure for t_service_ticket_reply
-- ----------------------------
DROP TABLE IF EXISTS `t_service_ticket_reply`;
CREATE TABLE `t_service_ticket_reply` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ticket_id` bigint NOT NULL COMMENT '工单ID',
  `user_type` tinyint NOT NULL COMMENT '回复人类型 1用户 2管理员',
  `user_id` bigint NOT NULL COMMENT '回复人ID',
  `content` text NOT NULL COMMENT '回复内容',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_service_ticket_reply_ticket_id` (`ticket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务工单回复表';

-- ----------------------------
-- Records of t_service_ticket_reply
-- ----------------------------
BEGIN;
INSERT INTO `t_service_ticket_reply` (`id`, `ticket_id`, `user_type`, `user_id`, `content`, `create_time`) VALUES (1, 1, 1, 1, '质量有问题', '2026-07-15 17:38:34');
INSERT INTO `t_service_ticket_reply` (`id`, `ticket_id`, `user_type`, `user_id`, `content`, `create_time`) VALUES (2, 1, 2, 0, '很抱歉给您带来不便，我们将进行核实并给您一个满意的答复。', '2026-07-15 17:41:04');
INSERT INTO `t_service_ticket_reply` (`id`, `ticket_id`, `user_type`, `user_id`, `content`, `create_time`) VALUES (3, 1, 2, 0, '核实中', '2026-07-15 17:41:28');
COMMIT;

-- ----------------------------
-- Table structure for t_sku
-- ----------------------------
DROP TABLE IF EXISTS `t_sku`;
CREATE TABLE `t_sku` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spu_id` bigint NOT NULL COMMENT '所属SPU',
  `spec_json` varchar(512) NOT NULL COMMENT '规格JSON',
  `price` decimal(10,2) NOT NULL COMMENT '售价',
  `stock` int NOT NULL DEFAULT '0' COMMENT '库存',
  `image` varchar(256) DEFAULT NULL COMMENT 'SKU图片',
  `sku_code` varchar(64) DEFAULT NULL COMMENT 'SKU编码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sku_code` (`sku_code`),
  KEY `idx_spu_id` (`spu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=168 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品规格表';

-- ----------------------------
-- Records of t_sku
-- ----------------------------
BEGIN;
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (1, 1, '{\"颜色\": \"默认款\"}', 849.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 'SKU000101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (2, 2, '{\"颜色\": \"默认款\"}', 129.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/05/30/0c694f385dd7a367313dd370bafad6b6.jpg', 'SKU000201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (3, 3, '{\"颜色\": \"默认款\"}', 39.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/4b0b14a657664fd3af6e1532724f60cf.jpg', 'SKU000301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (4, 4, '{\"颜色\": \"默认款\"}', 569.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fbf22777ba8014774a7d61221af4cb212_.jpg', 'SKU000401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (5, 5, '{\"颜色\": \"默认款\"}', 169.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/wms/product/img/productImg/2021/05/06/fd5ff30ea0554547b57da90d9ddc6e4e.jpg', 'SKU000501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (6, 6, '{\"颜色\": \"默认款\"}', 879.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fcc5dd61cbe6b41f482ee0959f0bffeda_.jpg', 'SKU000601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (7, 7, '{\"颜色\": \"默认款\"}', 439.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/09/14/2500x2500_79bf6b008d781edac094b4fdc0dfd755.jpg', 'SKU000701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (8, 8, '{\"颜色\": \"默认款\"}', 149.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/27/7f6a9624949e4870e23a1da143d7cceb.jpg', 'SKU000801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (9, 9, '{\"颜色\": \"默认款\"}', 259.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/03/2e0d695ae4664a42a95d6cb1f94c950d.jpg', 'SKU000901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (10, 10, '{\"颜色\": \"默认款\"}', 369.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/15/1aa9ad85dcd0c6f74eaa9c99a925c6de.jpg', 'SKU001001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (11, 11, '{\"颜色\": \"默认款\"}', 759.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/2/2024/07/01/1000x1000_0ad19df4b4d5d01dd5e78042b6e4d170.jpg', 'SKU001101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (12, 12, '{\"颜色\": \"默认款\"}', 1699.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 'SKU001201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (13, 13, '{\"颜色\": \"默认款\"}', 1229.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/07/14/2500x2500_2efb74b9e064bde39e004a495d93a0f1.jpg', 'SKU001301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (14, 14, '{\"颜色\": \"默认款\"}', 119.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/23/bdbf00f468a8ded51650f8f0e5c4a674.jpg', 'SKU001401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (15, 15, '{\"颜色\": \"默认款\"}', 149.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/08/26/0e579b525f16e750f48ccb05ffc20ad3.jpg', 'SKU001501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (16, 16, '{\"颜色\": \"默认款\"}', 39.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/644fd3682400434aa1ec7a6a29900252.jpg', 'SKU001601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (17, 17, '{\"颜色\": \"默认款\"}', 549.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F2d2c3c56ae4a44819976e966896e3904_.jpg', 'SKU001701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (18, 18, '{\"颜色\": \"默认款\"}', 139.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/08/08/2500x2500_c616918017879636c0b2ccffedf77ce2.jpg', 'SKU001801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (19, 19, '{\"颜色\": \"默认款\"}', 529.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 'SKU001901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (20, 20, '{\"颜色\": \"默认款\"}', 399.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/03/11/1600x1600_6c395b3c5665e9ac5f061a522a8087d8.jpg', 'SKU002001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (21, 21, '{\"颜色\": \"默认款\"}', 239.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/27/722b5dd9eebda38eb5e9121c48899bcf.jpg', 'SKU002101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (22, 22, '{\"颜色\": \"默认款\"}', 129.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/13/72c2e93e838e93ed36f06b5a41aca0cf.jpg', 'SKU002201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (23, 23, '{\"颜色\": \"默认款\"}', 559.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/21/2500x2500_390568db3b405673391efff11c946b67.jpg', 'SKU002301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (24, 24, '{\"颜色\": \"默认款\"}', 469.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/10/2500x2500_a169a6d705d39dbdeaf45fad7b859ed4.jpg', 'SKU002401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (25, 25, '{\"颜色\": \"默认款\"}', 189.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/27/8fa9bfbe10824bd95f98539b8609b067.jpg', 'SKU002501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (26, 26, '{\"颜色\": \"默认款\"}', 39.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/10/29/9712e0285ca942f28cbeaddea5203bda.jpg', 'SKU002601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (27, 27, '{\"颜色\": \"默认款\"}', 329.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/26/2500x2500_3e72594537a1b2436f2f0c09030daa24.jpg', 'SKU002701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (28, 28, '{\"颜色\": \"默认款\"}', 489.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 'SKU002801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (29, 29, '{\"颜色\": \"默认款\"}', 399.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/25/531dee4e99fe450eed268805c684f701.jpg', 'SKU002901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (30, 30, '{\"颜色\": \"默认款\"}', 169.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/07/27/d3a6fb58aca147b6aa12dfd9db6783b6.jpg', 'SKU003001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (31, 31, '{\"颜色\": \"默认款\"}', 889.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F4a7aa93485444f66ad6c996a1d42d970_.jpg', 'SKU003101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (32, 32, '{\"颜色\": \"默认款\"}', 589.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/01/28/2500x2500_40540d7c99ff2290e216b48fd934abf5.png', 'SKU003201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (33, 33, '{\"颜色\": \"默认款\"}', 1299.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/05/2500x2500_e6f5ae35807bf8158e19d26e692d9f7a.jpg', 'SKU003301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (34, 34, '{\"颜色\": \"默认款\"}', 479.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/04/29/2500x2500_c1a66af6c2eb3384c6f037fbfd4ab675.jpg', 'SKU003401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (35, 35, '{\"颜色\": \"默认款\"}', 149.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/25/2c28f7b491e2a037208a46e80e1b528c.jpg', 'SKU003501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (36, 36, '{\"颜色\": \"默认款\"}', 849.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/29/2500x2500_dc1af8279a54b865078420a9e828997c.jpg', 'SKU003601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (37, 37, '{\"颜色\": \"默认款\"}', 39.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/09/27/7d2710a09ff57e8f8484003b97f6eb39.jpg', 'SKU003701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (38, 38, '{\"颜色\": \"默认款\"}', 749.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/07/07/2ca54b65d3770c8f0d4d112e37333e0b.jpg', 'SKU003801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (39, 39, '{\"颜色\": \"默认款\"}', 719.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/06/26/2500x2500_3aa75149afca2776814b28dafe67d83a.jpg', 'SKU003901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (40, 40, '{\"颜色\": \"默认款\"}', 209.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/30/bb3329c26145543a2e8af12e30683f15.jpg', 'SKU004001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (41, 41, '{\"颜色\": \"默认款\"}', 939.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/26/b8d71ef80aa9a272cd99b68439108356.jpg', 'SKU004101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (42, 42, '{\"颜色\": \"默认款\"}', 1189.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/11/10/2500x2500_902010c380fcee94f93df189f2ca3f86.jpg', 'SKU004201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (43, 43, '{\"颜色\": \"默认款\"}', 2099.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 'SKU004301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (44, 44, '{\"颜色\": \"默认款\"}', 139.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/08/08/588259821cbecc99978d252ce7f65d02.jpg', 'SKU004401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (45, 45, '{\"颜色\": \"默认款\"}', 19.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/5bbded0f665f4722abca0e894a3d447c.jpg', 'SKU004501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (46, 46, '{\"颜色\": \"默认款\"}', 399.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/05/20/9593fceb25846cfee5584b82913f9dbd.jpg', 'SKU004601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (47, 47, '{\"颜色\": \"默认款\"}', 879.99, 119, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/04/23/2500x2500_9018865b20885a317875b2c28f11de1c.jpg', 'SKU004701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (48, 48, '{\"颜色\": \"默认款\"}', 229.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/19/1000x1000_9f7d6813fea1127808a03efefefd4079.jpg', 'SKU004801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (49, 49, '{\"颜色\": \"默认款\"}', 299.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/60fef9a124f244428757b3520d41df3c.jpg', 'SKU004901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (50, 50, '{\"颜色\": \"默认款\"}', 489.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/29/501c65f11d5ac44f2fca3e5596d271be.jpg', 'SKU005001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (51, 51, '{\"颜色\": \"默认款\"}', 1099.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 'SKU005101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (52, 52, '{\"颜色\": \"默认款\"}', 899.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/14/bc4c4758dec573376b35cfaebdfccbea.jpg', 'SKU005201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (53, 53, '{\"颜色\": \"默认款\"}', 229.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/wms/product/img/productImg/2021/05/05/884abe5502c14223b84105f950e762e4.jpg', 'SKU005301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (54, 54, '{\"颜色\": \"默认款\"}', 19.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/d550804b53eb440a8881aa572b15b9ad.jpg', 'SKU005401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (55, 55, '{\"颜色\": \"默认款\"}', 219.99, 118, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/07/31/2500x2500_6bbd99a408bab353919c6f4737bf6462.jpg', 'SKU005501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (56, 56, '{\"颜色\": \"默认款\"}', 359.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/07/12/4b2a448a6fec46fa9d699df82fa9c4cb.jpg', 'SKU005601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (57, 57, '{\"颜色\": \"默认款\"}', 439.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/17/a51e2aaf1f7eb1123ff317c2918c8224.jpg', 'SKU005701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (58, 58, '{\"颜色\": \"默认款\"}', 459.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/10/23/9e0f37a7886bdf2ccb4149b515b42a54.jpg', 'SKU005801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (59, 59, '{\"颜色\": \"默认款\"}', 79.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/26/bcd3dd5dfe918c480753acc96d986f98.jpg', 'SKU005901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (60, 60, '{\"颜色\": \"默认款\"}', 479.99, 119, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/22/2500x2500_92f82fbba644c5b9732aaf02e0757e5f.jpg', 'SKU006001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (61, 61, '{\"颜色\": \"默认款\"}', 119.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/02/27/2500x2500_0f36ed3c36e27d1ed14e8edc49681178.jpg', 'SKU006101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (62, 62, '{\"颜色\": \"默认款\"}', 339.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/23/88c27ecfe9bac0be38eb0ad007a00e96.jpg', 'SKU006201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (63, 63, '{\"颜色\": \"默认款\"}', 429.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/09/d2e1911c6d724f578bd0eba683d8dab2.jpg', 'SKU006301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (64, 64, '{\"颜色\": \"默认款\"}', 929.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fcf76038f7a16495e8d5de21b991a7ddc_.jpg', 'SKU006401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (65, 65, '{\"颜色\": \"默认款\"}', 239.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/09/26/fcc8ccf7c68b9814975fc7960e7d0cd9.jpg', 'SKU006501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (66, 66, '{\"颜色\": \"默认款\"}', 74.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/29/7be5fb1a45cef4332f69e14e8be33945.jpg', 'SKU006601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (67, 67, '{\"颜色\": \"默认款\"}', 959.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F755329f3ef014e259d9d0c81787c228e_.jpg', 'SKU006701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (68, 68, '{\"颜色\": \"默认款\"}', 429.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/01844ec6b8bb40049acd4925b76cc63c.jpg', 'SKU006801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (69, 69, '{\"颜色\": \"默认款\"}', 419.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/07/8a48b0c3e1562fd4ee2486b323d59f06.jpg', 'SKU006901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (70, 70, '{\"颜色\": \"默认款\"}', 239.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/f567815bd81b4251a900cd3baaa9d70f.jpg', 'SKU007001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (71, 71, '{\"颜色\": \"默认款\"}', 339.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/05/07/2500x2500_35541486a748d42f93d38c9b07f46323.jpg', 'SKU007101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (72, 72, '{\"颜色\": \"默认款\"}', 1399.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/12/02/2500x2500_7193d4eb29d00639ce4275b3ce21e8f9.jpg', 'SKU007201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (73, 73, '{\"颜色\": \"默认款\"}', 139.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/15/21de367270881061e9ce649785b13bd8.jpg', 'SKU007301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (74, 74, '{\"颜色\": \"默认款\"}', 1099.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/12/18/4000x4000_f2b601f5d5f1512a167ed67bb2dbcadf.jpg', 'SKU007401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (75, 75, '{\"颜色\": \"默认款\"}', 109.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/4a00ce43fb284625b34d3e711d661f40.jpg', 'SKU007501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (76, 76, '{\"颜色\": \"默认款\"}', 229.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/08/2378195d9ee846ba3989b7f4a2cf2d47.jpg', 'SKU007601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (77, 77, '{\"颜色\": \"默认款\"}', 569.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/12/10/2500x2500_c0b24aaa4672fe5fbf79b9b7425b32ff.jpg', 'SKU007701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (78, 78, '{\"颜色\": \"默认款\"}', 689.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/05/30/2500x2500_f4636b0ab9308d0ecea8111937f84f1a.jpg', 'SKU007801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (79, 79, '{\"颜色\": \"默认款\"}', 2349.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F99f5b65c3f8a452c90dc1a5481ca4f1b_.jpg', 'SKU007901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (80, 80, '{\"颜色\": \"默认款\"}', 109.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/05/28/4d93f3f75d6ef1a1a00259b1ddbac28b.jpg', 'SKU008001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (81, 81, '{\"颜色\": \"默认款\"}', 1359.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 'SKU008101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (82, 82, '{\"颜色\": \"默认款\"}', 129.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/10/7da227f77cc34d5da746fccda100191e.jpg', 'SKU008201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (83, 83, '{\"颜色\": \"默认款\"}', 849.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/common/2022/03/29/e552950b71708f93114f11d0806bb759.jpg', 'SKU008301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (84, 84, '{\"颜色\": \"默认款\"}', 339.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/01/993dcd6b692760bdcac5191a770dbf0c.jpg', 'SKU008401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (85, 85, '{\"颜色\": \"默认款\"}', 359.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/07/2500x2500_5e1fe90b2db1ff5ce3a871cb37b960ee.jpg', 'SKU008501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (86, 86, '{\"颜色\": \"默认款\"}', 79.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/30/f6d73ab6ebaf02a68b1f3e3eb4aa7b4d.jpg', 'SKU008601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (87, 87, '{\"颜色\": \"默认款\"}', 109.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/24/cce35a47474684b0328023b6d9555310.jpg', 'SKU008701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (88, 88, '{\"颜色\": \"默认款\"}', 119.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/04/5598539a27064a3e8af5438d2db11422.jpg', 'SKU008801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (89, 89, '{\"颜色\": \"默认款\"}', 159.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/13/a3f87666be6941f09269e4b8c40a84b9.jpg', 'SKU008901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (90, 90, '{\"颜色\": \"默认款\"}', 369.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/29/fa585b6f31cfd0824946663bc7dd055d.jpg', 'SKU009001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (91, 91, '{\"颜色\": \"默认款\"}', 599.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/21/2500x2500_54f9d36af129d803adcd415767462c11.jpg', 'SKU009101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (92, 92, '{\"颜色\": \"默认款\"}', 109.99, 119, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/10/24/f81de2732e038c7a0c4add9b5c7a2a2d.jpg', 'SKU009201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (93, 93, '{\"颜色\": \"默认款\"}', 789.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/08/27/2500x2500_5425251dfd2fac03dd2866c01054ec78.jpg', 'SKU009301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (94, 94, '{\"颜色\": \"默认款\"}', 119.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/07/6b6f8b1bcb9d4313c81f884ad2761c1f.jpg', 'SKU009401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (95, 95, '{\"颜色\": \"默认款\"}', 389.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/02/3000x3000_4730eb64fc61a5a912dba793748d2360.jpg', 'SKU009501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (96, 96, '{\"颜色\": \"默认款\"}', 689.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/02/3000x3000_1a06d432aae9a1014c9aaca43fddad43.jpg', 'SKU009601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (97, 97, '{\"颜色\": \"默认款\"}', 149.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/c008ab29e13d40089136537901b9f83b.jpg', 'SKU009701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (98, 98, '{\"颜色\": \"默认款\"}', 159.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/28/e9007f79ae2b2d8b3d791409f2c1e30e.jpg', 'SKU009801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (99, 99, '{\"颜色\": \"默认款\"}', 109.99, 120, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/22/a90109d094b64127b089e68b353ef625.jpg', 'SKU009901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (110, 100, '{\"颜色\":\"红\",\"尺码\":\"S\"}', 99.00, 94, NULL, 'AA1');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (111, 100, '{\"颜色\":\"红\",\"尺码\":\"M\"}', 99.00, 99, NULL, 'AA2');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (112, 100, '{\"颜色\":\"红\",\"尺码\":\"L\"}', 99.00, 99, NULL, 'AA3');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (113, 100, '{\"颜色\":\"黄\",\"尺码\":\"S\"}', 99.00, 99, NULL, 'AA4');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (114, 100, '{\"颜色\":\"黄\",\"尺码\":\"M\"}', 99.00, 99, NULL, 'AA5');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (115, 100, '{\"颜色\":\"黄\",\"尺码\":\"L\"}', 99.00, 99, NULL, 'AA6');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (116, 100, '{\"颜色\":\"蓝\",\"尺码\":\"S\"}', 99.00, 99, NULL, '7AA');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (117, 100, '{\"颜色\":\"蓝\",\"尺码\":\"M\"}', 99.00, 99, NULL, 'AA8');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (118, 100, '{\"颜色\":\"蓝\",\"尺码\":\"L\"}', 99.00, 99, NULL, 'AA9');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (119, 2001, '{\"颜色\": \"默认款\"}', 499.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_68018454ad18e690bce4b73791d09d1b.jpg', 'FS200101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (120, 2002, '{\"颜色\": \"默认款\"}', 2999.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/30/2500x2500_563885afd3a8fad87e374fb6d2743819.jpg', 'FS200201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (121, 2003, '{\"颜色\": \"默认款\"}', 1699.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 'FS200301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (122, 2004, '{\"颜色\": \"默认款\"}', 1059.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_776c68b2df6c5982e6f8940dc554d301.jpg', 'FS200401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (123, 2005, '{\"颜色\": \"默认款\"}', 2999.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/10/10/ca2b2248d9f08dac420975b5b2761632.jpg', 'FS200501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (124, 2006, '{\"颜色\": \"默认款\"}', 2889.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/ad7d891b853f1eda6eedb43a14a1bc63.jpg', 'FS200601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (125, 2007, '{\"颜色\": \"默认款\"}', 1199.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_d381d45f3b2b3f52b2913af302cef9d0.jpg', 'FS200701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (126, 2008, '{\"颜色\": \"默认款\"}', 719.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_8bd9e87f49e2482713fc3ab7f482bcc3.jpg', 'FS200801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (127, 2009, '{\"颜色\": \"默认款\"}', 1659.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/06/03/7aef181a1ba049c2bffe4341ab23b8be.jpg', 'FS200901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (128, 2010, '{\"颜色\": \"默认款\"}', 2199.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/9fbc03b404081fe1d1051daa11c0b1ef.jpg', 'FS201001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (129, 2011, '{\"颜色\": \"默认款\"}', 489.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 'FS201101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (130, 2012, '{\"颜色\": \"默认款\"}', 999.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/1600x1600_d441d16a02baa02b59a4c2a9fa071edc.jpg', 'FS201201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (131, 2013, '{\"颜色\": \"默认款\"}', 2299.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F4dbcf8ad6a4949639f30536645394236_.jpg', 'FS201301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (132, 2014, '{\"颜色\": \"默认款\"}', 2099.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 'FS201401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (133, 2015, '{\"颜色\": \"默认款\"}', 1699.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/1f3bc4195f48b9305df8370fdbc87550.jpg', 'FS201501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (134, 2016, '{\"颜色\": \"默认款\"}', 779.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_562a03bcaece63c7d0ce6cc5d6dea758.jpg', 'FS201601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (135, 2017, '{\"颜色\": \"默认款\"}', 1099.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 'FS201701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (136, 2018, '{\"颜色\": \"默认款\"}', 4299.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_ba661f0bcb8f8633e675b2e19034dca5.jpg', 'FS201801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (137, 2019, '{\"颜色\": \"默认款\"}', 799.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/a891337a4dd015aa12e8f002336146e0.jpg', 'FS201901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (138, 2020, '{\"颜色\": \"默认款\"}', 469.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/fba84dd2c9c3a805a2a3316380633cc6.jpg', 'FS202001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (139, 2021, '{\"颜色\": \"默认款\"}', 1749.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/10/09/a4792d81b5516d1936feacb64bb0ccf1.jpg', 'FS202101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (140, 2022, '{\"颜色\": \"默认款\"}', 1899.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/14/547b4c7517cd46a16dd5d244f2b33b54.jpg', 'FS202201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (141, 2023, '{\"颜色\": \"默认款\"}', 779.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_40c7a88c6f05da177ab46134f1839019.jpg', 'FS202301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (142, 2024, '{\"颜色\": \"默认款\"}', 849.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 'FS202401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (143, 2025, '{\"颜色\": \"默认款\"}', 4499.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/4096x4096_e88371d883ecaf8325aee489e48f3220.jpg', 'FS202501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (144, 2026, '{\"颜色\": \"默认款\"}', 979.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_c650adc2c9ffb688f8110be953c11b90.jpg', 'FS202601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (145, 2027, '{\"颜色\": \"默认款\"}', 789.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_c8beca0ba8fb1cde333cf205affe07a6.jpg', 'FS202701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (146, 2028, '{\"颜色\": \"默认款\"}', 3029.99, 79, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_ea17eff6265eef031a9e744b59401d72.jpg', 'FS202801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (147, 2029, '{\"颜色\": \"默认款\"}', 2699.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_f9e1630c9d1d0fa37e2a8afdc6be68aa.jpg', 'FS202901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (148, 2030, '{\"颜色\": \"默认款\"}', 2199.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/25/2500x2500_13e80149379d6220493ee0e264608b6b.jpg', 'FS203001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (149, 2031, '{\"颜色\": \"默认款\"}', 999.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_c310ad7ee843c59e6d3c496917427212.jpg', 'FS203101');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (150, 2032, '{\"颜色\": \"默认款\"}', 529.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 'FS203201');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (151, 2033, '{\"颜色\": \"默认款\"}', 1359.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 'FS203301');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (152, 2034, '{\"颜色\": \"默认款\"}', 1159.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/09/1600x1600_2cd0ae20465f41f320da1d6b4101fd08.jpg', 'FS203401');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (153, 2035, '{\"颜色\": \"默认款\"}', 239.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/aee18aa35e9368a30339efb69488e7db.jpg', 'FS203501');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (154, 2036, '{\"颜色\": \"默认款\"}', 849.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_21071fa7feb62ad532c7fe1283741f50.jpg', 'FS203601');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (155, 2037, '{\"颜色\": \"默认款\"}', 569.99, 78, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_dbc3adebd57965e5786c055992c93722.jpg', 'FS203701');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (156, 2038, '{\"颜色\": \"默认款\"}', 1279.99, 79, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_946e42f9a119f2110178e6839060786a.jpg', 'FS203801');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (157, 2039, '{\"颜色\": \"默认款\"}', 219.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_fb975dc166c10e23da4ab28783647699.jpg', 'FS203901');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (158, 2040, '{\"颜色\": \"默认款\"}', 3879.99, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F6b080a113c3048c7ad7e6ac555f79264_.jpg', 'FS204001');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (162, 2041, '{\"颜色\":\"胡桃木\",\"尺寸\":\"大\"}', 99.00, 100, NULL, 'X01');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (163, 2041, '{\"颜色\":\"胡桃木\",\"尺寸\":\"中\"}', 99.00, 100, NULL, 'X02');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (164, 2041, '{\"颜色\":\"胡桃木\",\"尺寸\":\"小\"}', 99.00, 100, NULL, 'X03');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (165, 2041, '{\"颜色\":\"原木色\",\"尺寸\":\"大\"}', 99.00, 100, NULL, 'X04');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (166, 2041, '{\"颜色\":\"原木色\",\"尺寸\":\"中\"}', 99.00, 100, NULL, 'X05');
INSERT INTO `t_sku` (`id`, `spu_id`, `spec_json`, `price`, `stock`, `image`, `sku_code`) VALUES (167, 2041, '{\"颜色\":\"原木色\",\"尺寸\":\"小\"}', 99.00, 100, NULL, 'X06');
COMMIT;

-- ----------------------------
-- Table structure for t_spu
-- ----------------------------
DROP TABLE IF EXISTS `t_spu`;
CREATE TABLE `t_spu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL COMMENT '商品名称',
  `category_id` bigint NOT NULL COMMENT '分类ID',
  `description` longtext COMMENT '商品详情描述(富文本)',
  `main_image` varchar(256) DEFAULT NULL COMMENT '主图URL',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0=下架 1=上架',
  `sales_count` int NOT NULL DEFAULT '0' COMMENT '累计销量',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=2042 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品主体表';

-- ----------------------------
-- Records of t_spu
-- ----------------------------
BEGIN;
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (1, '35\" 悬浮 单人 弧形 浴室柜 带水槽 & 储物', 31, 'Homary 精选浴室柜，35\" 悬浮 单人 弧形 浴室柜 带水槽 & 储物。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 1, 94, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2, '瀑布式 浴室 水槽 水龙头 金色 单把手 实心黄铜', 32, 'Homary 精选水龙头，瀑布式 浴室 水槽 水龙头 金色 单把手 实心黄铜。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/05/30/0c694f385dd7a367313dd370bafad6b6.jpg', 1, 138, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (3, '金色 成品 弹跳式 下水器 组件 带 溢水孔 浴室 Vessel 浴室柜 水槽', 11, 'Homary 精选客厅家具，金色 成品 弹跳式 下水器 组件 带 溢水孔 浴室 Vessel 浴室柜 水槽。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/4b0b14a657664fd3af6e1532724f60cf.jpg', 1, 84, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (4, 'Aro 59\" 落地式 浴室 储物 柜子 带 层架, 抽屉 & 门', 11, 'Homary 精选客厅家具，Aro 59\" 落地式 浴室 储物 柜子 带 层架, 抽屉 & 门。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fbf22777ba8014774a7d61221af4cb212_.jpg', 1, 65, '2026-07-13 13:59:42', '2026-07-14 10:03:16');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (5, '钢化玻璃客厅家具款', 11, 'Homary 精选客厅家具，钢化玻璃客厅家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/wms/product/img/productImg/2021/05/06/fd5ff30ea0554547b57da90d9ddc6e4e.jpg', 1, 397, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (6, '简约Hynova AX9 智能 Bidet Toilet 带 Powerful Flush, Built- Tank, Foam Shield, 1.28 GPF', 11, 'Homary 精选客厅家具，简约Hynova AX9 智能 Bidet Toilet 带 Powerful Flush, Built- Tank, Foam Shield, 1.28 GPF。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fcc5dd61cbe6b41f482ee0959f0bffeda_.jpg', 1, 433, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (7, '29\" 台下 多功能 厨房 水槽 带 水龙头 单人 盆 不锈钢', 52, 'Homary 精选水槽，29\" 台下 多功能 厨房 水槽 带 水龙头 单人 盆 不锈钢。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/09/14/2500x2500_79bf6b008d781edac094b4fdc0dfd755.jpg', 1, 282, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (8, '4-灯 LED Lear 厨房岛台 灯g 金色 带 玻璃 球形 灯罩 可调光', 41, 'Homary 精选吸顶灯，4-灯 LED Lear 厨房岛台 灯g 金色 带 玻璃 球形 灯罩 可调光。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/27/7f6a9624949e4870e23a1da143d7cceb.jpg', 1, 84, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (9, 'Phone Booth-Shaped 复古 儿童 书柜 Engl与 风格', 17, 'Homary 精选书桌，Phone Booth-Shaped 复古 儿童 书柜 Engl与 风格。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/03/2e0d695ae4664a42a95d6cb1f94c950d.jpg', 1, 313, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (10, '39\" 白色 装饰 玄关桌 带 岩板 台面', 15, 'Homary 精选茶几，39\" 白色 装饰 玄关桌 带 岩板 台面。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/15/1aa9ad85dcd0c6f74eaa9c99a925c6de.jpg', 1, 142, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (11, 'Grovyn 28\"-32\" 圆形 嵌套 茶几 套装 带 岩板 台面', 15, 'Homary 精选茶几，Grovyn 28\"-32\" 圆形 嵌套 茶几 套装 带 岩板 台面。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/2/2024/07/01/1000x1000_0ad19df4b4d5d01dd5e78042b6e4d170.jpg', 1, 171, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (12, '70.9\" 现代 风格 岩板 厨房岛台s 带 Multi-储物 白色', 53, 'Homary 精选厨房岛台，70.9\" 现代 风格 岩板 厨房岛台s 带 Multi-储物 白色。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 1, 184, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (13, '118寸庭院遮阳款', 24, 'Homary 精选庭院遮阳，118寸庭院遮阳款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/07/14/2500x2500_2efb74b9e064bde39e004a495d93a0f1.jpg', 1, 239, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (14, '简约户外 Garden Sleepg Buddha Statue Sculpture Magnesium Oxide Flower Pot Planter Decor', 21, 'Homary 精选户外家具，简约户外 Garden Sleepg Buddha Statue Sculpture Magnesium Oxide Flower Pot Planter Decor。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/23/bdbf00f468a8ded51650f8f0e5c4a674.jpg', 1, 446, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (15, '现代 典雅 瀑布式 浴室 台上盆 水龙头 单把手 实心黄铜 金色', 32, 'Homary 精选水龙头，现代 典雅 瀑布式 浴室 台上盆 水龙头 单把手 实心黄铜 金色。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/08/26/0e579b525f16e750f48ccb05ffc20ad3.jpg', 1, 219, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (16, '仿古 黄铜 台上盆 Pop Up 下水器 带 溢水孔 实心黄铜', 11, 'Homary 精选客厅家具，仿古 黄铜 台上盆 Pop Up 下水器 带 溢水孔 实心黄铜。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/644fd3682400434aa1ec7a6a29900252.jpg', 1, 145, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (17, 'Artis 59\" 浴室 储物 柜子 – 落地式 Len 高柜 带 2 抽屉 & 2 门', 11, 'Homary 精选客厅家具，Artis 59\" 浴室 储物 柜子 – 落地式 Len 高柜 带 2 抽屉 & 2 门。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F2d2c3c56ae4a44819976e966896e3904_.jpg', 1, 261, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (18, '15.7\" 陶瓷 圆形 浴室 台上盆 复古 洗漱台盆', 11, 'Homary 精选客厅家具，15.7\" 陶瓷 圆形 浴室 台上盆 复古 洗漱台盆。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/08/08/2500x2500_c616918017879636c0b2ccffedf77ce2.jpg', 1, 421, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (19, 'Glow K1 智能 Bidet Toilet 带 加热 Seat & Rear Ambient 灯, 1.32 GPF', 11, 'Homary 精选客厅家具，Glow K1 智能 Bidet Toilet 带 加热 Seat & Rear Ambient 灯, 1.32 GPF。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 1, 420, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (20, '25寸现代单人水槽款', 52, 'Homary 精选水槽，25寸现代单人水槽款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/03/11/1600x1600_6c395b3c5665e9ac5f061a522a8087d8.jpg', 1, 280, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (21, '12 灯 黑色 吊灯 带 球形 玻璃 灯罩 现代 吊灯 客厅', 41, 'Homary 精选吸顶灯，12 灯 黑色 吊灯 带 球形 玻璃 灯罩 现代 吊灯 客厅。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/27/722b5dd9eebda38eb5e9121c48899bcf.jpg', 1, 147, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (22, '23.6\'\' Giraffe 藤编 Floor Toy 储物 Basket', 11, 'Homary 精选客厅家具，23.6\'\' Giraffe 藤编 Floor Toy 储物 Basket。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/13/72c2e93e838e93ed36f06b5a41aca0cf.jpg', 1, 143, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (23, '现代 39\" Demilune 玄关桌 带 白色 岩板 台面', 15, 'Homary 精选茶几，现代 39\" Demilune 玄关桌 带 白色 岩板 台面。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/21/2500x2500_390568db3b405673391efff11c946b67.jpg', 1, 91, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (24, '47寸现代胡桃木茶几款', 15, 'Homary 精选茶几，47寸现代胡桃木茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/10/2500x2500_a169a6d705d39dbdeaf45fad7b859ed4.jpg', 1, 487, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (25, '26寸户外家具款', 21, 'Homary 精选户外家具，26寸户外家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/27/8fa9bfbe10824bd95f98539b8609b067.jpg', 1, 26, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (26, '现代黄铜客厅家具款', 11, 'Homary 精选客厅家具，现代黄铜客厅家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/10/29/9712e0285ca942f28cbeaddea5203bda.jpg', 1, 40, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (27, '落地式 与 壁挂式 白色 Adjus桌子 浴室 柜子 带储物', 11, 'Homary 精选客厅家具，落地式 与 壁挂式 白色 Adjus桌子 浴室 柜子 带储物。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/26/2500x2500_3e72594537a1b2436f2f0c09030daa24.jpg', 1, 79, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (28, 'Fitro H1 Compact 智能 Bidet Toilet 带 Deodorization 与 Automatic Flushg, 1.32 GPF', 11, 'Homary 精选客厅家具，Fitro H1 Compact 智能 Bidet Toilet 带 Deodorization 与 Automatic Flushg, 1.32 GPF。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 1, 50, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (29, '32寸现代单人水槽款', 52, 'Homary 精选水槽，32寸现代单人水槽款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/25/531dee4e99fe450eed268805c684f701.jpg', 1, 251, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (30, 'Jewell 1-灯 黄铜 Geometric 吊灯 带 Water-ripple 玻璃 灯罩', 41, 'Homary 精选吸顶灯，Jewell 1-灯 黄铜 Geometric 吊灯 带 Water-ripple 玻璃 灯罩。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/07/27/d3a6fb58aca147b6aa12dfd9db6783b6.jpg', 1, 376, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (31, '60寸岩板胡桃木茶几款', 15, 'Homary 精选茶几，60寸岩板胡桃木茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F4a7aa93485444f66ad6c996a1d42d970_.jpg', 1, 419, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (32, '47寸茶几款', 15, 'Homary 精选茶几，47寸茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/01/28/2500x2500_40540d7c99ff2290e216b48fd934abf5.png', 1, 88, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (33, '81寸现代胡桃木厨房岛台款', 53, 'Homary 精选厨房岛台，81寸现代胡桃木厨房岛台款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/05/2500x2500_e6f5ae35807bf8158e19d26e692d9f7a.jpg', 1, 212, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (34, '118寸庭院遮阳款', 24, 'Homary 精选庭院遮阳，118寸庭院遮阳款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/04/29/2500x2500_c1a66af6c2eb3384c6f037fbfd4ab675.jpg', 1, 28, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (35, '户外 Garden Geometric Japanese Solar Lantern Sculpture Statue Asian Decor 灰色', 21, 'Homary 精选户外家具，户外 Garden Geometric Japanese Solar Lantern Sculpture Statue Asian Decor 灰色。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/25/2c28f7b491e2a037208a46e80e1b528c.jpg', 1, 297, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (36, '36\" 现代 壁挂式 浴室柜 带 LED 灯, 胡桃木色 柜子 & 陶瓷 水槽', 31, 'Homary 精选浴室柜，36\" 现代 壁挂式 浴室柜 带 LED 灯, 胡桃木色 柜子 & 陶瓷 水槽。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/29/2500x2500_dc1af8279a54b865078420a9e828997c.jpg', 1, 427, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (37, '黄铜客厅家具款', 11, 'Homary 精选客厅家具，黄铜客厅家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/09/27/7d2710a09ff57e8f8484003b97f6eb39.jpg', 1, 28, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (38, '34寸落地圆形客厅家具款', 11, 'Homary 精选客厅家具，34寸落地圆形客厅家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/07/07/2ca54b65d3770c8f0d4d112e37333e0b.jpg', 1, 85, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (39, 'Hynova AX2 Pro 智能 Bidet Toilet 带 Aromatherapy, 白色, 1.28 GPF', 11, 'Homary 精选客厅家具，Hynova AX2 Pro 智能 Bidet Toilet 带 Aromatherapy, 白色, 1.28 GPF。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/06/26/2500x2500_3aa75149afca2776814b28dafe67d83a.jpg', 1, 316, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (40, '现代吸顶灯款', 41, 'Homary 精选吸顶灯，现代吸顶灯款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/30/bb3329c26145543a2e8af12e30683f15.jpg', 1, 422, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (41, '现代 金色 玄关桌 岩板 台面 Entryway 储物 柜子 带 门', 15, 'Homary 精选茶几，现代 金色 玄关桌 岩板 台面 Entryway 储物 柜子 带 门。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/26/b8d71ef80aa9a272cd99b68439108356.jpg', 1, 392, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (42, '39寸现代岩板茶几款', 15, 'Homary 精选茶几，39寸现代岩板茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/11/10/2500x2500_902010c380fcee94f93df189f2ca3f86.jpg', 1, 395, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (43, '72寸现代岩板厨房岛台款', 53, 'Homary 精选厨房岛台，72寸现代岩板厨房岛台款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 1, 156, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (44, '26寸户外家具款', 21, 'Homary 精选户外家具，26寸户外家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/08/08/588259821cbecc99978d252ce7f65d02.jpg', 1, 172, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (45, 'Square Escutcheon Plate 浴室柜 水槽 水龙头 Hole Cover Deck Plate Polished 镀铬', 31, 'Homary 精选浴室柜，Square Escutcheon Plate 浴室柜 水槽 水龙头 Hole Cover Deck Plate Polished 镀铬。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/5bbded0f665f4722abca0e894a3d447c.jpg', 1, 305, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (46, '落地客厅家具款', 11, 'Homary 精选客厅家具，落地客厅家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/05/20/9593fceb25846cfee5584b82913f9dbd.jpg', 1, 489, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (47, 'Airloo 智能 Bidet Toilet 带 Built- Tank, UV Sterilization 与 Foam Shield, Dual Flush 1.1/1.6 GPF', 11, 'Homary 精选客厅家具，Airloo 智能 Bidet Toilet 带 Built- Tank, UV Sterilization 与 Foam Shield, Dual Flush 1.1/1.6 GPF。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/04/23/2500x2500_9018865b20885a317875b2c28f11de1c.jpg', 1, 428, '2026-07-13 13:59:42', '2026-07-16 17:45:52');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (48, '23.6寸吸顶灯款', 41, 'Homary 精选吸顶灯，23.6寸吸顶灯款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/19/1000x1000_9f7d6813fea1127808a03efefefd4079.jpg', 1, 56, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (49, '32寸现代茶几款', 15, 'Homary 精选茶几，32寸现代茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/60fef9a124f244428757b3520d41df3c.jpg', 1, 148, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (50, '43寸茶几款', 15, 'Homary 精选茶几，43寸茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/29/501c65f11d5ac44f2fca3e5596d271be.jpg', 1, 270, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (51, 'Jap与i 72\" 白色 厨房岛台 带储物 & LED 灯g', 44, 'Homary 精选台灯落地灯，Jap与i 72\" 白色 厨房岛台 带储物 & LED 灯g。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 1, 39, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (52, 'Aro 35\" 悬浮 单人 浴室柜 带水槽, 岩板 台面', 31, 'Homary 精选浴室柜，Aro 35\" 悬浮 单人 浴室柜 带水槽, 岩板 台面。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/14/bc4c4758dec573376b35cfaebdfccbea.jpg', 1, 290, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (53, '金色 现代 浴室 三孔式 水槽 水龙头 双把手 黄铜', 32, 'Homary 精选水龙头，金色 现代 浴室 三孔式 水槽 水龙头 双把手 黄铜。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/wms/product/img/productImg/2021/05/05/884abe5502c14223b84105f950e762e4.jpg', 1, 54, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (54, 'Square Escutcheon Plate 浴室柜 水槽 水龙头 Hole Cover Deck Plate Matte 黑色', 31, 'Homary 精选浴室柜，Square Escutcheon Plate 浴室柜 水槽 水龙头 Hole Cover Deck Plate Matte 黑色。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/d550804b53eb440a8881aa572b15b9ad.jpg', 1, 436, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (55, '15.7\" 黑色 4-抽屉 浴室 柜子 带 壁挂式 or Floor-st与g', 11, 'Homary 精选客厅家具，15.7\" 黑色 4-抽屉 浴室 柜子 带 壁挂式 or Floor-st与g。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/07/31/2500x2500_6bbd99a408bab353919c6f4737bf6462.jpg', 1, 272, '2026-07-13 13:59:42', '2026-07-16 17:45:52');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (56, '现代吸顶灯款', 41, 'Homary 精选吸顶灯，现代吸顶灯款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/07/12/4b2a448a6fec46fa9d699df82fa9c4cb.jpg', 1, 252, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (57, '39.4寸现代茶几款', 15, 'Homary 精选茶几，39.4寸现代茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/17/a51e2aaf1f7eb1123ff317c2918c8224.jpg', 1, 336, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (58, '47寸茶几款', 15, 'Homary 精选茶几，47寸茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/10/23/9e0f37a7886bdf2ccb4149b515b42a54.jpg', 1, 443, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (59, '22.2寸户外家具款', 21, 'Homary 精选户外家具，22.2寸户外家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/26/bcd3dd5dfe918c480753acc96d986f98.jpg', 1, 215, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (60, '浴室柜 套装 27.9\" 现代 悬浮 陶瓷 浴室柜 黑色 带水槽', 31, 'Homary 精选浴室柜，浴室柜 套装 27.9\" 现代 悬浮 陶瓷 浴室柜 黑色 带水槽。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/22/2500x2500_92f82fbba644c5b9732aaf02e0757e5f.jpg', 1, 450, '2026-07-13 13:59:42', '2026-07-14 11:19:08');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (61, '双人水龙头款', 32, 'Homary 精选水龙头，双人水龙头款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/02/27/2500x2500_0f36ed3c36e27d1ed14e8edc49681178.jpg', 1, 255, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (62, '不锈钢水槽款', 52, 'Homary 精选水槽，不锈钢水槽款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/23/88c27ecfe9bac0be38eb0ad007a00e96.jpg', 1, 82, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (63, '现代吸顶灯款', 41, 'Homary 精选吸顶灯，现代吸顶灯款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/09/d2e1911c6d724f578bd0eba683d8dab2.jpg', 1, 132, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (64, '18\"-47\" 圆形 混凝土 Veneer 胡桃木色 茶几 套装', 15, 'Homary 精选茶几，18\"-47\" 圆形 混凝土 Veneer 胡桃木色 茶几 套装。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fcf76038f7a16495e8d5de21b991a7ddc_.jpg', 1, 436, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (65, '原木色 Solid Wood Garden Cart Display Plant St与 Pottg Bench', 21, 'Homary 精选户外家具，原木色 Solid Wood Garden Cart Display Plant St与 Pottg Bench。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/09/26/fcc8ccf7c68b9814975fc7960e7d0cd9.jpg', 1, 261, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (66, '21.9寸户外家具款', 21, 'Homary 精选户外家具，21.9寸户外家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/29/7be5fb1a45cef4332f69e14e8be33945.jpg', 1, 435, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (67, 'Panvyr 36\" 单人 浴室柜 带水槽 与 岩板 台面', 31, 'Homary 精选浴室柜，Panvyr 36\" 单人 浴室柜 带水槽 与 岩板 台面。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F755329f3ef014e259d9d0c81787c228e_.jpg', 1, 261, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (68, 'Kaol Clay Pedestal 水槽 洗漱 水槽 带 下水器 & 水龙头 户外 与 door', 21, 'Homary 精选户外家具，Kaol Clay Pedestal 水槽 洗漱 水槽 带 下水器 & 水龙头 户外 与 door。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/01844ec6b8bb40049acd4925b76cc63c.jpg', 1, 227, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (69, '不锈钢水槽款', 52, 'Homary 精选水槽，不锈钢水槽款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/07/8a48b0c3e1562fd4ee2486b323d59f06.jpg', 1, 256, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (70, '圆形吸顶灯款', 41, 'Homary 精选吸顶灯，圆形吸顶灯款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/f567815bd81b4251a900cd3baaa9d70f.jpg', 1, 244, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (71, '圆形岩板茶几款', 15, 'Homary 精选茶几，圆形岩板茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/05/07/2500x2500_35541486a748d42f93d38c9b07f46323.jpg', 1, 62, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (72, '现代 50\" Wood 厨房岛台 带 抽屉 & 柜子s, 白色', 53, 'Homary 精选厨房岛台，现代 50\" Wood 厨房岛台 带 抽屉 & 柜子s, 白色。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/12/02/2500x2500_7193d4eb29d00639ce4275b3ce21e8f9.jpg', 1, 186, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (73, '22.4寸户外家具款', 21, 'Homary 精选户外家具，22.4寸户外家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/15/21de367270881061e9ce649785b13bd8.jpg', 1, 20, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (74, '浴室柜 套装 59\" 现代 悬浮 浴室柜 白色 与 原木色 带水槽', 31, 'Homary 精选浴室柜，浴室柜 套装 59\" 现代 悬浮 浴室柜 白色 与 原木色 带水槽。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/12/18/4000x4000_f2b601f5d5f1512a167ed67bb2dbcadf.jpg', 1, 182, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (75, '单人水龙头款', 32, 'Homary 精选水龙头，单人水龙头款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/4a00ce43fb284625b34d3e711d661f40.jpg', 1, 338, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (76, '单人不锈钢水槽款', 52, 'Homary 精选水槽，单人不锈钢水槽款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/08/2378195d9ee846ba3989b7f4a2cf2d47.jpg', 1, 346, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (77, '47寸现代岩板茶几款', 15, 'Homary 精选茶几，47寸现代岩板茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/12/10/2500x2500_c0b24aaa4672fe5fbf79b9b7425b32ff.jpg', 1, 284, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (78, '47寸岩板茶几款', 15, 'Homary 精选茶几，47寸岩板茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/05/30/2500x2500_f4636b0ab9308d0ecea8111937f84f1a.jpg', 1, 122, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (79, '72寸岩板厨房岛台款', 53, 'Homary 精选厨房岛台，72寸岩板厨房岛台款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F99f5b65c3f8a452c90dc1a5481ca4f1b_.jpg', 1, 372, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (80, '25寸户外家具款', 21, 'Homary 精选户外家具，25寸户外家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/05/28/4d93f3f75d6ef1a1a00259b1ddbac28b.jpg', 1, 167, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (81, 'Aro 59\" 落地式 双人 浴室柜 带水槽, 岩板 台面', 31, 'Homary 精选浴室柜，Aro 59\" 落地式 双人 浴室柜 带水槽, 岩板 台面。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 1, 451, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (82, 'Grop 当代 瀑布式 浴室 水龙头 镀铬', 32, 'Homary 精选水龙头，Grop 当代 瀑布式 浴室 水龙头 镀铬。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/10/7da227f77cc34d5da746fccda100191e.jpg', 1, 37, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (83, '33寸单人水槽款', 52, 'Homary 精选水槽，33寸单人水槽款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/common/2022/03/29/e552950b71708f93114f11d0806bb759.jpg', 1, 270, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (84, '现代吸顶灯款', 41, 'Homary 精选吸顶灯，现代吸顶灯款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/01/993dcd6b692760bdcac5191a770dbf0c.jpg', 1, 469, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (85, '47寸茶几款', 15, 'Homary 精选茶几，47寸茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/07/2500x2500_5e1fe90b2db1ff5ce3a871cb37b960ee.jpg', 1, 37, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (86, '4 Tier Multifunctional Tall Tiered Wood 户外 Plant St与 Display Shelf Rack 原木色', 21, 'Homary 精选户外家具，4 Tier Multifunctional Tall Tiered Wood 户外 Plant St与 Display Shelf Rack 原木色。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/30/f6d73ab6ebaf02a68b1f3e3eb4aa7b4d.jpg', 1, 52, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (87, '户外 Garden Japanese Solar Lantern Sculpture 混凝土 灰色 Fiber玻璃 Asian Decor', 21, 'Homary 精选户外家具，户外 Garden Japanese Solar Lantern Sculpture 混凝土 灰色 Fiber玻璃 Asian Decor。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/24/cce35a47474684b0328023b6d9555310.jpg', 1, 47, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (88, '现代 Design 单把手 1-Hole 黑色 浴室 水槽 水龙头 带 瀑布式 Sp 黄铜', 32, 'Homary 精选水龙头，现代 Design 单把手 1-Hole 黑色 浴室 水槽 水龙头 带 瀑布式 Sp 黄铜。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/04/5598539a27064a3e8af5438d2db11422.jpg', 1, 204, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (89, '32\" 黑色 不锈钢 厨房 水槽 双人 盆s 台下 水槽 带 下水器 与 溢水孔', 52, 'Homary 精选水槽，32\" 黑色 不锈钢 厨房 水槽 双人 盆s 台下 水槽 带 下水器 与 溢水孔。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/13/a3f87666be6941f09269e4b8c40a84b9.jpg', 1, 269, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (90, 'Enseo Coastal 5-灯 Capiz Shell 2 Tiered Faceted 吊灯 吊灯 金色 白色', 41, 'Homary 精选吸顶灯，Enseo Coastal 5-灯 Capiz Shell 2 Tiered Faceted 吊灯 吊灯 金色 白色。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/29/fa585b6f31cfd0824946663bc7dd055d.jpg', 1, 254, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (91, '47寸现代大理石茶几款', 15, 'Homary 精选茶几，47寸现代大理石茶几款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/21/2500x2500_54f9d36af129d803adcd415767462c11.jpg', 1, 279, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (92, '30寸户外家具款', 21, 'Homary 精选户外家具，30寸户外家具款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/10/24/f81de2732e038c7a0c4add9b5c7a2a2d.jpg', 1, 320, '2026-07-13 13:59:42', '2026-07-14 11:19:08');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (93, 'Artis 36\" 悬浮 单人 浴室柜 带水槽, 岩板 台面, 大容量 储物', 31, 'Homary 精选浴室柜，Artis 36\" 悬浮 单人 浴室柜 带水槽, 岩板 台面, 大容量 储物。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/08/27/2500x2500_5425251dfd2fac03dd2866c01054ec78.jpg', 1, 180, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (94, '瀑布式单人黄铜水龙头款', 32, 'Homary 精选水龙头，瀑布式单人黄铜水龙头款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/07/6b6f8b1bcb9d4313c81f884ad2761c1f.jpg', 1, 311, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (95, '25.6寸现代书桌款', 17, 'Homary 精选书桌，25.6寸现代书桌款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/02/3000x3000_4730eb64fc61a5a912dba793748d2360.jpg', 1, 74, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (96, '现代 39.4\" 悬浮 单人 浴室柜 带水槽 黑色, 岩板 台面', 31, 'Homary 精选浴室柜，现代 39.4\" 悬浮 单人 浴室柜 带水槽 黑色, 岩板 台面。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/02/3000x3000_1a06d432aae9a1014c9aaca43fddad43.jpg', 1, 196, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (97, '瀑布式单人水龙头款', 32, 'Homary 精选水龙头，瀑布式单人水龙头款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/c008ab29e13d40089136537901b9f83b.jpg', 1, 443, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (98, '30寸单人不锈钢水槽款', 52, 'Homary 精选水槽，30寸单人不锈钢水槽款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/28/e9007f79ae2b2d8b3d791409f2c1e30e.jpg', 1, 176, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (99, '现代吸顶灯款', 41, 'Homary 精选吸顶灯，现代吸顶灯款。进口品质工艺，设计感十足，适配多种家装风格。', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/22/a90109d094b64127b089e68b353ef625.jpg', 1, 297, '2026-07-13 13:59:42', '2026-07-13 13:59:42');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (100, '浴室柜 套装 31.5\" 现代 悬浮 浴室柜 带水槽', 65, '<p>Homary 精选浴室柜，浴室柜 套装 31.5\" 现代 悬浮 浴室柜 带水槽。进口品质工艺，设计感十足，适配多种家装风格。</p>', 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/05/21/2500x2500_eb75b5a609a45e2c5a715d1547a0002a.jpg', 1, 390, '2026-07-13 13:59:42', '2026-07-16 20:33:19');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2001, '日式胡桃木卧室家具款', 14, '<h3>日式胡桃木卧室家具款</h3>\n<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Embodying the essence of 日式, this 地板床 is ideal those who appreciate simplicity 与 practicality. Its low-profile, minimalist desi…</p>\n<ul>\n<li>闪购精选 Low-profile design a sleek, minimalist look that saves space 与 adds a serene vibe to your room</li>\n<li>闪购精选 Made 带 premium rubberwood veneer, eco-friendly 与 durable long-lasting quality</li>\n<li>闪购精选 Carbon steel slats provide excellent weight support 与 resist corrosion 与 rust over time</li>\n<li>闪购精选 No headboard design an open, clutter-free aesthetic that complements any room layout</li>\n<li>Embraces a minimalist 日式, ideal creating a peaceful, 现代 卧室 atmosphere</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_68018454ad18e690bce4b73791d09d1b.jpg', 1, 4, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2002, '模块柚木沙发款', 12, '<h3>模块柚木沙发款</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>This modular 火坑桌 沙发 套装 combines 现代 design 带 户外 comfort 与 versatility. It features a customizable 模块沙发 带 plush cushions, a match…</p>\n<ul>\n<li>闪购精选 【Safety】CSA cetificated 火坑桌, 50,000 BTU max output, equivalent to the heat of 6 fireplaces</li>\n<li>【Health】Smokeless propane-fueled 火坑桌 桌子 makes your patio warm 与 healthy</li>\n<li>【Frame】灯er but higher strength 与 hardness 铝制 alloy, anti-rust 与 provides more stability</li>\n<li>【Material】柚木 wood surface, 带 原木色 oils 与 rubber, protecting the wood from weathering 与 ageing</li>\n<li>闪购精选 【Cushion】Waterproof polyester upholstery, high elasticity foam padding, stains&amp;spills resistant 与 comfor桌子</li>\n<li>闪购精选 【Design】Modular design allows versatile configurations to suit any patio or garden layout, such as L型, I-shaped as you lik…</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/30/2500x2500_563885afd3a8fad87e374fb6d2743819.jpg', 1, 1000, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2003, '70.9\" 现代 Style 岩板 厨房岛台s 带 Multi-储物 白色', 53, '<h3>70.9\" 现代 Style 岩板 厨房岛台s 带 Multi-储物 白色</h3>\n<p>Homary Flash Sale 精选【厨房岛台】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>This 现代 厨房岛台 features a sleek 白色 岩板 top, perfect any 当代 厨房. 带 3 抽屉, 3 doors, 与 5 shelves, it keeps all your essentials organize…</p>\n<ul>\n<li>闪购精选 Spacious Workspace – Large countertop provides room meal prep, casual dining, or entertaining</li>\n<li>Premium Surface – 岩板 resists scratches, heat, 与 stains keeping your 岛台 loo国王尺寸 new</li>\n<li>Ample 储物 – 抽屉, doors, 与 shelves organize cookware, utensils, 与 pantry items</li>\n<li>Multifunctional Design – Serves as prep area, 餐桌, or workstation flexible 厨房 use</li>\n<li>现代 Style – Sleek 白色 design elevates 厨房 aesthetics while fitting any 当代 space</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 1, 1, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2004, '83\"岩板胡桃木电视柜款', 18, '<h3>83\"岩板胡桃木电视柜款</h3>\n<p>Homary Flash Sale 精选【电视柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Designed 现代 与 timeless interiors, the Aura 电视柜 brings mid-century warmth to your 客厅 带 ash wood fluted details 与 a travertine st…</p>\n<ul>\n<li>闪购精选 The fluted design 带 ash wood slats adds depth 与 mid-century character to your space</li>\n<li>The 岩板 top is scratch-resistant 与 easy to clean, staying 典雅 over time</li>\n<li>闪购精选 Four-level ambient 灯ing creates a warm atmosphere relaxed evenings at home</li>\n<li>Spacious 柜子s provide generous 储物 while keeping your living area visually balanced</li>\n<li>闪购精选 Cable management keeps wires neatly hidden a clean, uncluttered 套装up</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_776c68b2df6c5982e6f8940dc554d301.jpg', 1, 96, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2005, '71\"双人花洒款', 33, '<h3>71\"双人花洒款</h3>\n<p>Homary Flash Sale 精选【花洒】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Indulge your own 人al luxury 带 this 71\" double massage acrylic corner 浴缸, featuring space two bathers. Enhance your bathing 带 38…</p>\n<ul>\n<li>闪购精选 38 massage jets deliver targeted water pressure muscle relief</li>\n<li>闪购精选 Temperature control helps maintain water temperature at its optimal level at all times</li>\n<li>闪购精选 瀑布式 back massage adds soothing water flow along the spine</li>\n<li>闪购精选 Air bubble system creates gentle micro-bubbles to stimulate skin</li>\n<li>闪购精选 120° ergonomic reclined backrest 与 headrest relieve neck 与 back pressure</li>\n<li>闪购精选 LED chromotherapy 灯s offer 7 colors mood adjustment</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/10/10/ca2b2248d9f08dac420975b5b2761632.jpg', 1, 33, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2006, '3-件 棉麻 L型 组合沙发 带 Side Open 储物', 12, '<h3>3-件 棉麻 L型 组合沙发 带 Side Open 储物</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Embrace 现代 living 带 this spacious 组合沙发, designed flexibility 与 comfort. Its cotton-linen upholstery ensures airflow 与 softness,…</p>\n<ul>\n<li>Breathable cotton-linen fabric keeps the 沙发 cool 与 comfor桌子 during long use</li>\n<li>闪购精选 Modular design allows you to rearrange 件套 a custom fit any room layout</li>\n<li>Two 储物 side 桌子s provide space to organize items like books 与 snacks neatly</li>\n<li>闪购精选 Extra-wide seating comfortably accommodates up to nine people social events</li>\n<li>闪购精选 Durable engineered wood frame ensures stability 与 long-term reliability</li>\n<li>闪购精选 Includes six plush pillows extra support 与 a welcoming look your space</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/ad7d891b853f1eda6eedb43a14a1bc63.jpg', 1, 58, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2007, '铝制休闲椅款', 16, '<h3>铝制休闲椅款</h3>\n<p>Homary Flash Sale 精选【休闲椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Elevate your 户外 relaxation 带 this sleek 与 现代 chaise lounge. Designed 带 both style 与 comfort mind, it features a minimalist 黑色 m…</p>\n<ul>\n<li>FSC-certified 柚木 与 premium 铝制 create a strong, weather-ready frame built long-term 户外 use</li>\n<li>闪购精选 Adjus桌子 backrest easily adjust the recline angle reading, napping, or sunbathing to maximize relaxation</li>\n<li>闪购精选 Fade, mildew, 与 water-resistant canvas cushions 带 removable covers easy cleaning 与 long-term use</li>\n<li>闪购精选 Extra-thick 7.5\" cushion offers enhanced comfort sitting or reclining 户外s</li>\n<li>Built- 柚木 side 桌子, offers a s桌子 surface drinks 与 books, eliminating the need an extra 户外 桌子</li>\n<li>Quick 1-人 partial assembly, includes all hardware easy 套装up 带out professional help</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_d381d45f3b2b3f52b2913af302cef9d0.jpg', 1, 1000, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2008, 'Hynova AX2 Pro 智能马桶 带 Aromatherapy, 白色, 1.28 GPF', 33, '<h3>Hynova AX2 Pro 智能马桶 带 Aromatherapy, 白色, 1.28 GPF</h3>\n<p>Homary Flash Sale 精选【花洒】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Elevate your 浴室 带 our Automatic 智能马桶 featuring vibrant color ambient 灯ing 与 aromatherapy. Enjoy auto open lid, 加热 seat, 与 adjus…</p>\n<ul>\n<li>闪购精选 Auto Open Lid: Lid opens automatically as the user approaches, reducing contact 带 surfaces h与s-free convenience</li>\n<li>加热 Seat: Adjus桌子 temperature 套装tings provide 人alized warmth year-round comfort</li>\n<li>Adjus桌子 Nozzle Wash: Water angle 与 pressure adjust to 人al preference a tailored cleansing experience</li>\n<li>Warm Air Dryer: Three temperature 套装tings allow users to select comfor桌子 drying after washing</li>\n<li>闪购精选 Aromatherapy Function: Dispenses scent from essential oils to create a customized 浴室 atmosphere</li>\n<li>Vibrant Color Ambient 灯ing: Dynamic colored 灯s offer customizable visual ambiance the 浴室</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_8bd9e87f49e2482713fc3ab7f482bcc3.jpg', 1, 1, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2009, '83\"弧形丝绒沙发款', 12, '<h3>83\"弧形丝绒沙发款</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Defined by a sculptural curved silhouette 与 plush 丝绒 upholstery, this 现代 沙发 creates an inviting lounge spot conversation or qui…</p>\n<ul>\n<li>Plush 丝绒 upholstery 带 high-density foam cushions provides soft comfort, lasting support 与 maintain their shape over time</li>\n<li>闪购精选 Solid wood frame provides strong foundation 与 ensures years of reliable use</li>\n<li>不锈钢 legs add 现代 elegance 与 s桌子 support to the 沙发 design</li>\n<li>闪购精选 Easy assembly just requires attaching the legs so you can start using it quickly</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/06/03/7aef181a1ba049c2bffe4341ab23b8be.jpg', 1, 71, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2010, '126\"L型模块皮质沙发款', 12, '<h3>126\"L型模块皮质沙发款</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>This 当代 126\" L型 组合沙发, featuring modular components 带 a matching ottoman Its modular design gives great flexibility to arrange t…</p>\n<ul>\n<li>闪购精选 Modular sectional layout adapts to room shapes flexible family seating</li>\n<li>闪购精选 Reversible chaise design switches sides to fit different 客厅 layouts</li>\n<li>Built- console 带 hidden 储物 keeps remotes 与 snacks 带in easy reach</li>\n<li>闪购精选 High-density foam cushions provide comfor桌子 support extended lounging</li>\n<li>科技皮 resists stains, water 与 与 daily wear, keeping the 沙发 easy to clean 与 lasting daily use</li>\n<li>Solid wood legs offer sturdy support 与 a touch of 原木色 style to the 沙发</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/9fbc03b404081fe1d1051daa11c0b1ef.jpg', 1, 242, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2011, 'Fitro H1 Compact 智能马桶 带 Deodorization 与 Automatic Flushing, 1.32 GPF', 33, '<h3>Fitro H1 Compact 智能马桶 带 Deodorization 与 Automatic Flushing, 1.32 GPF</h3>\n<p>Homary Flash Sale 精选【花洒】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>This floor-mounted 智能马桶 combines space-saving compact design 带 full-size functionality. Featuring automatic flush, 加热 seat, 与 a…</p>\n<ul>\n<li>闪购精选 Built- deodorizer removes odors to keep 浴室 air fresh</li>\n<li>One-件 compact design saves space while adding a 现代 look to any 浴室</li>\n<li>闪购精选 Automatic flush activates when user leaves seat h与s-free hygiene</li>\n<li>加热 seat 带 adjus桌子 temperature provides comfort during cold mornings</li>\n<li>闪购精选 Customizable warm wash adjusts water temperature, pressure, 与 nozzle position</li>\n<li>闪购精选 Warm air dryer eliminates toilet paper a comfor桌子, thorough dry</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 1, 1, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2012, '铝制休闲椅款', 16, '<h3>铝制休闲椅款</h3>\n<p>Homary Flash Sale 精选【休闲椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Transform your 户外 living space 带 this stylish 与 functional swivel lounge 椅子. Designed 带 a sturdy, rust-resistant 铝制 frame 与 uph…</p>\n<ul>\n<li>FSC-certified 柚木 与 premium 铝制 create a strong, weather-ready frame built lasting 户外 use</li>\n<li>闪购精选 360° swivel design lets you turn easily to chat, reach, or enjoy different views more comfortably</li>\n<li>6\" thick cushion adds supportive comfort, ma国王尺寸 long 户外 lounging feel more relaxed 与 enjoyable</li>\n<li>闪购精选 Fade, mildew, 与 water-resistant canvas cushions 带 removable covers easy cleaning 与 long-term use</li>\n<li>闪购精选 Removable cushion covers make routine cleaning easier, helping you spend less time on upkeep</li>\n<li>Quick 1-人 partial assembly, includes all hardware easy 套装up 带out professional help</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/1600x1600_d441d16a02baa02b59a4c2a9fa071edc.jpg', 1, 1000, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2013, 'Costra 4-件 户外 绳编 Swivel 沙发 套装 带 茶几 黑色 6', 12, '<h3>Costra 4-件 户外 绳编 Swivel 沙发 套装 带 茶几 黑色 6</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Bring effortless Coastal style to your patio 带 a durable 铝制 frame, weather-resistant 绳编, 与 performance 户外 fabric. This 4-件 户外沙发…</p>\n<ul>\n<li>铝制 alloy frame resists rust 与 weather long-term 户外 durability</li>\n<li>H与woven 绳编 finish 带st与s fading, moisture, 与 mildew while adding texture</li>\n<li>闪购精选 High performance canvas cushions are UV- 与 water-resistant 带 removable covers easy care</li>\n<li>360° swivel lounge 椅子 allows smooth movement relaxed 户外 conversations</li>\n<li>闪购精选 Extra-thick 7.5\" cushions 与 28.7\" deep seats offer plush, extended comfort</li>\n<li>Complete 4-件 套装 includes 3-seater 沙发, 2-seater 沙发, 1 旋转椅, 与 1 茶几</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F4dbcf8ad6a4949639f30536645394236_.jpg', 1, 54, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2014, '中古风 72\" Glossy 岩板 Top 厨房岛台 带储物, 原木色', 53, '<h3>中古风 72\" Glossy 岩板 Top 厨房岛台 带储物, 原木色</h3>\n<p>Homary Flash Sale 精选【厨房岛台】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Made open 厨房s, daily coo国王尺寸, 与 family gatherings, the 厨房岛台 adds prep space, seating room, 与 organized 储物 to keep routines smoo…</p>\n<ul>\n<li>闪购精选 岩板 top resists heat, stains, 与 scratches easier daily prep</li>\n<li>抽屉, compartments, 与 trash 储物 keep cookware 与 bins organized</li>\n<li>闪购精选 Wide countertop supports food prep, casual meals, 与 serving during gatherings</li>\n<li>闪购精选 Rubberwood frame 带 ash veneer front adds steady support 与 lasting structure</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 1, 360, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2015, '84\"弧形丝绒沙发款', 12, '<h3>84\"弧形丝绒沙发款</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Elevate your space immediately 带 this 3-seater 沙发 boasting a graceful curved silhouette 与 premium 丝绒 fabric. Arrives fully asse…</p>\n<ul>\n<li>闪购精选 Premium 丝绒 upholstery feels incredibly soft 与 adds a refined touch</li>\n<li>闪购精选 Solid wood frame ensures lasting durability 与 reliable support everyday use</li>\n<li>闪购精选 High-density foam cushions provide comfor桌子 seating that maintains its shape over time</li>\n<li>闪购精选 Curved backrest creates an 典雅 silhouette that enhances aesthetic appeal</li>\n<li>闪购精选 Requires no assembly - simply unbox 与 start enjoying your 沙发 immediately</li>\n<li>闪购精选 Includes complementary pillows added comfort 与 complete styling</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/1f3bc4195f48b9305df8370fdbc87550.jpg', 1, 54, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2016, '60\"胡桃木书桌款', 17, '<h3>60\"胡桃木书桌款</h3>\n<p>Homary Flash Sale 精选【书桌】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>This versatile 书桌 combines 现代 elegance 带 practical features. The lift-top design creates an ergonomic workspace sitting or st与i…</p>\n<ul>\n<li>闪购精选 Lift-top design lets you switch sitting or st与ing all-day comfort at home office</li>\n<li>闪购精选 Ash wood frame adds stability daily remote work, studying, 与 灯 gaming</li>\n<li>Compact structure 带 built- 储物 fits small apartments, dorms, 与 home offices</li>\n<li>闪购精选 Hidden 柜子s keep your workspace clutter-free during work, study, or creative tasks</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_562a03bcaece63c7d0ce6cc5d6dea758.jpg', 1, 334, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2017, '日式简约 72\" 白色 厨房岛台 带储物 & LED 灯ing', 44, '<h3>日式简约 72\" 白色 厨房岛台 带储物 & LED 灯ing</h3>\n<p>Homary Flash Sale 精选【台灯落地灯】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>日式简约 厨房岛台 带储物 designed 厨房 与 餐厅 spaces. Available multiple sizes 与 colors, it offers scratch-resistant surface, practical 储物, 与 …</p>\n<ul>\n<li>闪购精选 Scratch-resistant 与 easy-to-clean 桌子top everyday use</li>\n<li>厨房岛台 带储物 to keep essentials organized</li>\n<li>闪购精选 Durable engineered wood construction long-term stability</li>\n<li>闪购精选 Multiple size options to fit different space needs</li>\n<li>Ideal 餐厅 储物, meal prep, 与 family gatherings</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 1, 211, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2018, '9-件套 仿大理石 户外 Dining 套装 带 Woven Rope 椅子s 8 人 (86.6\")', 13, '<h3>9-件套 仿大理石 户外 Dining 套装 带 Woven Rope 椅子s 8 人 (86.6\")</h3>\n<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>This 典雅 garden 桌子 套装, featuring a sophisticated stone-effect 桌子top 与 a robust 铝制 frame, combines timeless aesthetics 带 durabili…</p>\n<ul>\n<li>【Easy-care 桌子top】: 典雅 stone look, heat- 与 scratch-resistant, easy to remove oil 与 red wine stains</li>\n<li>【Premium 铝制 frame】: 灯er than steel, just as robust, weatherproof, 与 easy to move – ideal 户外 dining</li>\n<li>闪购精选 【Like new years】: H与-woven rope 带 a breathable feel that is waterproof, quick-drying, 与 fade-resistant</li>\n<li>【Comfor桌子 seat】: Softly padded seat 与 back cushions, as well as ergonomic backrest 与 armrests, ensure comfort even during exten…</li>\n<li>闪购精选 【Easy-care cover】: Waterproof, scratch-resistant, fade-resistant, 与 stain-resistant, as well as removable 与 washable</li>\n<li>【Contents】: 餐桌 ×1, 餐椅s ×8, including cushions 与 pads</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_ba661f0bcb8f8633e675b2e19034dca5.jpg', 1, 169, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2019, '皮质浴室柜款', 31, '<h3>皮质浴室柜款</h3>\n<p>Homary Flash Sale 精选【浴室柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Humply makeup 浴室柜 套装 performance 仿皮 is designed style-conscious users, pairing a 灯ed 镜子, multiple-抽屉 储物, 与 a matching stool to …</p>\n<ul>\n<li>闪购精选 Performance 仿皮 is water-resistant, stain-resistant, 与 scratch-resistant easy care</li>\n<li>3-color 灯ed 镜子 带 cool, warm, 与 day灯 modes supports clearer, more precise makeup</li>\n<li>Five spacious 抽屉 keep beauty tools 与 daily essentials neatly organized 与 close</li>\n<li>Foam-filled stool 带 metal base brings comfor桌子 seating 与 a polished look</li>\n<li>Rounded sculptural design gives the 浴室柜 a softer silhouette 与 st与out 现代 appeal</li>\n<li>闪购精选 FSC Certified – Made 带 responsibly sourced FSC-certified wood conscious, sustainable quality</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/a891337a4dd015aa12e8f002336146e0.jpg', 1, 108, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2020, 'Fero 71\"-110\" 可伸缩 电视柜 带 3 抽屉', 18, '<h3>Fero 71\"-110\" 可伸缩 电视柜 带 3 抽屉</h3>\n<p>Homary Flash Sale 精选【电视柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>The Fero 电视柜 exp与s to fit any space, from compact apartments to expansive 客厅s. Three deep 抽屉 glide open on quiet soft-close run…</p>\n<ul>\n<li>闪购精选 Exp与s from 71\" to 110\" to fit your space exactly, no matter the size</li>\n<li>闪购精选 Three 抽屉 keeps remotes 与 cables tucked away instead of tangled up</li>\n<li>闪购精选 Soft-close 抽屉 glide quietly so every touch ends 带 a gentle close</li>\n<li>闪购精选 Crafted from FSC-certified wood, a responsible choice that feels as good as it looks</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/fba84dd2c9c3a805a2a3316380633cc6.jpg', 1, 325, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2021, '毛绒胡桃木卧室家具款', 14, '<h3>毛绒胡桃木卧室家具款</h3>\n<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Curva 毛绒 地板床 brings soft upholstery, a rounded headboard, 与 curved leg design into a sculptural 卧室 center件, balancing cozy comf…</p>\n<ul>\n<li>闪购精选 毛绒 upholstery wraps the frame 带 soft texture cozy daily comfort</li>\n<li>闪购精选 Solid pine wood frame provides reliable support long-term nightly use</li>\n<li>闪购精选 Carbon steel slats reinforce the base 与 help support the mattress</li>\n<li>闪购精选 Rounded headboard creates a gentle backdrop reading, lounging, 与 rest</li>\n<li>闪购精选 Curved legs add sculptural beauty 与 soften the overall 卧室 silhouette</li>\n<li>闪购精选 Low platform profile creates a grounded look that feels clean 与 现代</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/10/09/a4792d81b5516d1936feacb64bb0ccf1.jpg', 1, 392, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2022, '71\"现代L型书桌款', 17, '<h3>71\"现代L型书桌款</h3>\n<p>Homary Flash Sale 精选【书桌】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Built executive offices or spacious home workspaces, this bold L型 书桌 brings focus, order, 与 presence to the room. The wide 书桌to…</p>\n<ul>\n<li>闪购精选 63\" main 书桌top gives monitors, notes, 与 daily tools a generous place to stay ready</li>\n<li>71\" return creates a defined work zone, ma国王尺寸 the room feel organized 与 intentional</li>\n<li>Three roomy 抽屉 keep files, stationery, 与 人al essentials neatly out of sight</li>\n<li>Built- 柜子 储物 gives larger office items a home 带out crowding the 书桌top</li>\n<li>闪购精选 Vented 柜子 helps improve airflow a computer tower or devices stored inside</li>\n<li>闪购精选 Refined surface 与 sculptural base create a polished focal point 现代 workspaces</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/14/547b4c7517cd46a16dd5d244f2b33b54.jpg', 1, 453, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2023, '63\"岩板茶几款', 15, '<h3>63\"岩板茶几款</h3>\n<p>Homary Flash Sale 精选【茶几】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Designed 餐厅s 与 open-plan 厨房s, this sideboard supports daily dining, family gatherings, 与 厨房 储物 needs. The 岩板 top resists heat 与…</p>\n<ul>\n<li>Adjus桌子 shelves support flexible 储物 dinnerware 与 厨房 essentials</li>\n<li>闪购精选 岩板 top resists heat, scratches, 与 stains easy daily cleaning</li>\n<li>闪购精选 Wood 柜子 structure provides reliable support 与 lasting everyday durability</li>\n<li>Sideboard fits 餐厅s, open-plan 厨房s, 与 现代 home layouts easily</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_40c7a88c6f05da177ab46134f1839019.jpg', 1, 187, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2024, '35\"悬浮弧形浴室柜款', 31, '<h3>35\"悬浮弧形浴室柜款</h3>\n<p>Homary Flash Sale 精选【浴室柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Defined by a 悬浮 silhouette 与 a curved half-circle form, the 浴室柜 套装 combines a durable stone resin top 与 generous 储物 to bring cl…</p>\n<ul>\n<li>悬浮 壁挂式 design maximizes floor space 与 creates a clean 现代 look</li>\n<li>闪购精选 Stone resin top 与 水槽 offers durable, easy-care performance</li>\n<li>Undermount 水槽 keeps the countertop loo国王尺寸 clean 与 seamless</li>\n<li>Two 抽屉 与 one 柜子 keep toiletries neatly organized 与 accessible</li>\n<li>闪购精选 Available multiple colors 与 directional options to suit different spaces 与 styles</li>\n<li>Ready installation 带 st与ard single-hole 水龙头s 与 integrated overflow prevents accidental spillover</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 1, 106, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2025, '模块柚木沙发款', 12, '<h3>模块柚木沙发款</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Turn your backyard into a luxurious retreat 带 this premium 柚木 户外 sectional. Crafted those who appreciate both style 与 durabilit…</p>\n<ul>\n<li>闪购精选 户外 & indoor use</li>\n<li>7 件套 套装: This complete 套装 沙发 & 茶几 contains a total of 7 件套. 4 沙发s 与 3 茶几s, which can be freely combined to create scenarios 带 d…</li>\n<li>闪购精选 Adap桌子 Modular Design</li>\n<li>Premium 柚木 Craftsmanship 沙发 套装</li>\n<li>【Cloud-Like Comfort】 水槽 into deep, generously padded cushions upholstered 户外 performance fabric that repels moisture 与 resists …</li>\n<li>【Effortless Elegance】 带 its clean lines, warm 柚木 finish, 与 subtly curved armrests, this 沙发 blends 现代 sophistication 带 a relaxed…</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/4096x4096_e88371d883ecaf8325aee489e48f3220.jpg', 1, 1000, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2026, 'Humply 59\" 白色 皮质 9-抽屉 梳妆台', 14, '<h3>Humply 59\" 白色 皮质 9-抽屉 梳妆台</h3>\n<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Designed 现代 卧室s, Humply 梳妆台 performance PU 皮质 is ideal style-conscious homeowners, offering durable, easy-care 储物 that keeps cl…</p>\n<ul>\n<li>闪购精选 Performance PU 皮质 is spill-resistant, stain-resistant, 与 scratch-resistant easy upkeep</li>\n<li>Multiple spacious 抽屉 keep clothes 与 essentials organized, tidy, 与 easy to access</li>\n<li>闪购精选 Rounded 抽屉 fronts soften the silhouette while helping reduce bumps daily use</li>\n<li>闪购精选 皮质-wrapped finish adds refined texture 与 delivers durable, low-maintenance appeal</li>\n<li>现代 streamlined design elevates the room while adding practical concealed 储物</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_c650adc2c9ffb688f8110be953c11b90.jpg', 1, 160, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2027, '81\"可转换丝绒沙发款', 12, '<h3>81\"可转换丝绒沙发款</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>The modular sleeper 沙发 blends clean lines 带 flexible comfort 与 transforms into a cozy 床 minutes. Adjus桌子 backrests 与 headrests …</p>\n<ul>\n<li>Easy modular design switches smoothly between 沙发 与 床 modes</li>\n<li>Soft 雪尼尔 丝绒 feels cosy 与 resists everyday scratches</li>\n<li>闪购精选 Plush cushioning 带 high-density foam supports sit 与 sleep comfort</li>\n<li>不锈钢 frame adds strength, stability, 与 a clean 现代 edge</li>\n<li>闪购精选 Multiple layout options adapt easily to different rooms 与 routines</li>\n<li>闪购精选 Compressed foam exp与s fully 带in 24-72 hours, 与 a quick steam treatment helps remove remaining creases a flawless look</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_c8beca0ba8fb1cde333cf205affe07a6.jpg', 1, 41, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2028, '铝制餐桌椅款', 13, '<h3>铝制餐桌椅款</h3>\n<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>This thoughtfully designed 桌子 has a built- umbrella hole, allowing you to add shade 与 enjoy al fresco dining on sunny days. Its…</p>\n<ul>\n<li>【Frame】Sturdy 与 weather-resistant 灯weight 铝制 alloy ensures long-lasting 户外 durability, perfect all seasons</li>\n<li>【桌子top】柚木 wood, a sustainable material that is 原木色ly moisture-resistant 与 resistant to warping or rotting</li>\n<li>【Seating】铝制 frame 带 wood grain trim, offering sturdiness 与 rust-proof durability, ensuring long-lasting use</li>\n<li>【Design】Features an umbrella hole, allowing you to easily add an 户外 umbrella sun protection or rain coverage, ma国王尺寸 it highly …</li>\n<li>闪购精选 【Occasion】 Ideal al fresco dining, from family meals to entertaining guests</li>\n<li>【Content】 餐桌*1, dining椅子s*6,Includes cushions 与 pillows</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_ea17eff6265eef031a9e744b59401d72.jpg', 1, 1001, '2026-07-14 16:02:46', '2026-07-16 17:45:52');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2029, 'Tevara 可转换 户外 组合沙发 套装 带 柚木 & 铝制 Frame, 灰色', 12, '<h3>Tevara 可转换 户外 组合沙发 套装 带 柚木 & 铝制 Frame, 灰色</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Transform your backyard into a relaxing retreat 带 the Tevara 现代 modular 户外沙发 套装. Crafted 带 premium 柚木 accents 与 durable, weathe…</p>\n<ul>\n<li>Adjus桌子 seat converts into a chaise lounge 人alized seating 与 lounging comfort</li>\n<li>闪购精选 All-weather High-Performance Fabric delivers fade, water, mildew, stain, 与 scratch-resistant performance pet-friendly peac…</li>\n<li>High-strength 铝制 alloy frame is 灯weight yet rust-resistant lasting 户外 stability</li>\n<li>Premium 柚木 wood surface 带 原木色 oils resists weathering 与 aging lasting beauty, 带 subtle variations color 与 grain inherent to 原木色…</li>\n<li>闪购精选 Flexible modular design lets you mix, match, 与 exp与 to fit spaces from small patios to large backyards</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_f9e1630c9d1d0fa37e2a8afdc6be68aa.jpg', 1, 141, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2030, '悬浮毛绒卧室家具款', 14, '<h3>悬浮毛绒卧室家具款</h3>\n<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Elevate your 卧室 带 the Curva 国王尺寸 床. Features no-shedding 毛绒, a wide headboard, 与 sturdy frame. Includes 悬浮 床头柜s 带 LED/wireless …</p>\n<ul>\n<li>智能 床头柜s 带 LED 与 wireless charging offer power 与 ambient glow</li>\n<li>No-shedding 白色 毛绒 与 a wide headboard provide soft, durable comfort</li>\n<li>闪购精选 Sturdy eucalyptus frame 与 carbon steel slats ensure long-lasting stability</li>\n<li>闪购精选 落地式 platform design eliminates box springs a clean, simple look</li>\n<li>闪购精选 This product is sold 带out a mattress, allowing you to choose one that best suits your preferences</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/25/2500x2500_13e80149379d6220493ee0e264608b6b.jpg', 1, 159, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2031, 'Slatera 户外 金合欢木 & 铝制 模块沙发 套装 Dark 灰色', 12, '<h3>Slatera 户外 金合欢木 & 铝制 模块沙发 套装 Dark 灰色</h3>\n<p>Homary Flash Sale 精选【沙发组合】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Blending modular flexibility 带 warm 金合欢木 accents, Slatera 组合沙发 套装 brings durable comfort 与 a more versatile layout to patios, d…</p>\n<ul>\n<li>Powder-coated 铝制 frame resists rust 与 weather reliable 户外 use</li>\n<li>FSC-certified 金合欢木 accents add 原木色 warmth 带 responsibly sourced appeal</li>\n<li>闪购精选 Modular sections can form a sectional or 日床-style layout to suit your space</li>\n<li>Water-resistant fabric helps h与le 灯 moisture 与 everyday 户外 messes</li>\n<li>Built- side 桌子s keep drinks, books, 与 essentials conveniently 带in reach</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_c310ad7ee843c59e6d3c496917427212.jpg', 1, 190, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2032, 'Glowin K1 智能马桶 带 加热 Seat & Rear Ambient 灯, 1.32 GPF', 33, '<h3>Glowin K1 智能马桶 带 加热 Seat & Rear Ambient 灯, 1.32 GPF</h3>\n<p>Homary Flash Sale 精选【花洒】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Elevate your 浴室 style 带 this ultra-现代 Elongated One-件 白色 智能 Toilet. The 加热 seat comes 带 temperature control, while the self-cle…</p>\n<ul>\n<li>加热 Seat 带 Adjus桌子 Temperature: Comfort throughout the year</li>\n<li>闪购精选 Self-Cleaning Bidet Nozzle: Adjus桌子 water pressure 与 temperature</li>\n<li>闪购精选 Water-Saving 1.32 GPF Flush: Eco-friendly 带 efficient performance</li>\n<li>闪购精选 Soft-Close Lid & Auto Open/Close: Convenience 带 quiet operation</li>\n<li>闪购精选 Remote Control Operation: Full control at your fingertips</li>\n<li>闪购精选 Rear Ambient 灯: Soft illumination guides nighttime visits</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 1, 1, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2033, '59\"双人岩板浴室柜款', 31, '<h3>59\"双人岩板浴室柜款</h3>\n<p>Homary Flash Sale 精选【浴室柜】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Aro 浴室柜 pairs a 岩板 countertop 带 a ceramic undermount 水槽, offering generous 储物 与 a clean 现代 look master baths, guest baths, 与 po…</p>\n<ul>\n<li>闪购精选 岩板 countertop adds a durable, easy-clean surface daily use</li>\n<li>Ceramic undermount 水槽 keeps the 浴室柜 top smooth, neat, 与 easy to wipe</li>\n<li>Multiple 抽屉 与 柜子s provide ample 储物 everyday essentials</li>\n<li>Soft-close 抽屉 与 doors reduce noise a smoother 浴室 routine</li>\n<li>Ready installation 带 st与ard 水龙头 hole 与 integrated overflow prevents accidental spillover</li>\n<li>闪购精选 Available multiple colors, sizes, 与 single or double 水槽 options</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 1, 243, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2034, '63\"田园可伸缩胡桃木餐桌椅款', 13, '<h3>63\"田园可伸缩胡桃木餐桌椅款</h3>\n<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Designed flexible dining, this 田园风 可伸缩 餐桌 exp与s weekday meals or guests, 带 a wood-look top 与 a metal 与 engineered wood base a w…</p>\n<ul>\n<li>可伸缩 餐桌 adjusts easily daily meals, family visits, or extra guests</li>\n<li>Wood-look 桌子top brings 田园风 warmth 带out ma国王尺寸 the 餐厅 feel heavy</li>\n<li>Metal 与 engineered wood base adds s桌子 support while keeping leg space comfor桌子</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/09/1600x1600_2cd0ae20465f41f320da1d6b4101fd08.jpg', 1, 160, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2035, '皮质卧室家具款', 14, '<h3>皮质卧室家具款</h3>\n<p>Homary Flash Sale 精选【卧室家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Humply 床头柜 features a curved silhouette that brings a soft, 现代 touch to the 卧室. It combines integrated charging 与 practical 储物 …</p>\n<ul>\n<li>Eco-friendly engineered wood wrapped 科技皮 delivers a refined 与 durable finish</li>\n<li>科技皮 offers water, stain, 与 scratch resistance effortless everyday maintenance</li>\n<li>闪购精选 Built- charging station includes USB, Type-C, 与 wireless charging convenient power access</li>\n<li>Spacious 抽屉 provide ample 储物 daily essentials 与 卧室 items</li>\n<li>闪购精选 Delivered fully assembled, ready to use right out of the box 带 no installation required</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/aee18aa35e9368a30339efb69488e7db.jpg', 1, 1, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2036, '39\"日式简约可伸缩胡桃木餐桌椅款', 13, '<h3>39\"日式简约可伸缩胡桃木餐桌椅款</h3>\n<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Ideal daily dining, family gatherings, or small spaces,this 可伸缩 餐桌 transitions from round to oval, seating up to 6 people. Made…</p>\n<ul>\n<li>This 可伸缩 餐桌 exp与s from round to oval, seating up to 6 family meals</li>\n<li>闪购精选 Solid wood construction ensures long-lasting durability 与 stability</li>\n<li>闪购精选 Ideal small spaces, offering stylish seating 带out compromising functionality</li>\n<li>日式简约-inspired design adds 现代 elegance to any 厨房 or dining area</li>\n<li>The round 桌子 design offers added safety, ma国王尺寸 it ideal families 带 children</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_21071fa7feb62ad532c7fe1283741f50.jpg', 1, 453, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2037, '37\"客厅家具款', 11, '<h3>37\"客厅家具款</h3>\n<p>Homary Flash Sale 精选【客厅家具】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Transform cramped entryways into organized spaces 带 this versatile shoe 柜子 that extends when you need more room 与 swivels to se…</p>\n<ul>\n<li>Extend the main 柜子 extra shoe 储物 or collapse it to save space</li>\n<li>闪购精选 Swivel the side unit to create a h与y bench, then tuck it away when not needed</li>\n<li>闪购精选 Durable rubberwood panels resist daily wear while adding 原木色 visual appeal</li>\n<li>Adjus桌子 shelves customize 储物 different shoe heights, from flats to boots</li>\n<li>闪购精选 Rounded corners on all edges help prevent bumps 与 injuries busy homes</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_dbc3adebd57965e5786c055992c93722.jpg', 1, 327, '2026-07-14 16:02:46', '2026-07-16 20:33:19');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2038, '118\"庭院遮阳款', 24, '<h3>118\"庭院遮阳款</h3>\n<p>Homary Flash Sale 精选【庭院遮阳】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Transform your 户外 space 带 this 118\" cantilever umbrella designed 现代 patio living. Built 带 a sturdy 铝制 frame, UV-resistant water…</p>\n<ul>\n<li>闪购精选 360°rotating canopy lets you adjust shade direction freely throughout the day continuous sun protection</li>\n<li>Rust-resistant 铝制 frame 与 waterproof fade-resistant canopy ensure long-lasting 户外 performance all seasons</li>\n<li>闪购精选 Off套装 cantilever design provides wide uninterrupted shade 带out a center pole, maximizing usable patio space</li>\n<li>闪购精选 8.1 oz UPF 30+ polyester canopy blocks over 97% of UV rays to protect skin 与 户外 furniture</li>\n<li>闪购精选 220 lb granite base keeps the umbrella firmly s桌子 与 prevents tipping winds up to 25 mph</li>\n<li>闪购精选 Pulley lift system allows one-人 smooth opening 与 closing of the canopy 带 minimal effort</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_946e42f9a119f2110178e6839060786a.jpg', 1, 44, '2026-07-14 16:02:46', '2026-07-16 20:33:19');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2039, '6-灯 LED Linear 厨房岛台 灯ing 金色 带 Glass Globe Shade Dimmable', 41, '<h3>6-灯 LED Linear 厨房岛台 灯ing 金色 带 Glass Globe Shade Dimmable</h3>\n<p>Homary Flash Sale 精选【吸顶灯】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>This linear 岛台 灯 features a minimalist LED strip 与 glass globe design, cleverly combined to create a chic statement. This 现代 ve…</p>\n<ul>\n<li>闪购精选 Wave-shaped 金色 frame 带 crystal globe accents</li>\n<li>闪购精选 Built- LED 灯s</li>\n<li>闪购精选 High-quality materials ensure long-lasting beauty 与 functionality</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_fb975dc166c10e23da4ab28783647699.jpg', 1, 1, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2040, '绳编餐桌椅款', 13, '<h3>绳编餐桌椅款</h3>\n<p>Homary Flash Sale 精选【餐桌椅】。进口品质工艺，设计感十足，适配多种家装风格。</p>\n<p>Designed relaxed garden living, this 8-seat patio dining 套装 features a weather-resistant 铝制 桌子 与 h与-woven 绳编 椅子s. Built backyar…</p>\n<ul>\n<li>闪购精选 Weather-resistant 铝制 frame resists rust 与 UV rays, ensuring lasting durability garden</li>\n<li>闪购精选 H与-woven all-weather rope resists fading 与 moisture, keeping its texture season after season</li>\n<li>闪购精选 Removable cushion covers water-resistant fabric make cleaning up spills simple 与 stress-free</li>\n<li>闪购精选 Seat cushions 带 plush padding provide comfor桌子 support long meals garden</li>\n<li>闪购精选 Generous 8-seat layout accommodates family gatherings 与 dinner parties 带 room everyone</li>\n</ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F6b080a113c3048c7ad7e6ac555f79264_.jpg', 1, 197, '2026-07-14 16:02:46', '2026-07-14 16:02:46');
INSERT INTO `t_spu` (`id`, `name`, `category_id`, `description`, `main_image`, `status`, `sales_count`, `create_time`, `update_time`) VALUES (2041, 'Mordel 63\"-94\" 可伸缩 胡桃木 电视柜 带储物', 18, '<h3>Mordel 63\"-94\" 可伸缩 胡桃木 电视柜 带储物</h3><p>Homary Flash Sale 精选【电视柜】。进口品质工艺，设计感十足，适配多种家装风格。</p><p>Designed 现代 homes, Mordel 可伸缩 电视柜 adjusts from 63″ to 94″ 与 pairs clean lines 带 hidden 储物, adapting easily from compact spaces …</p><ul><li>闪购精选 Extends from 63″ to 94″ flexible placement different spaces</li><li>闪购精选 Scratch-resistant surface helps maintain a clean, refined look</li><li>闪购精选 Spacious 储物 keeps media gear 与 daily essentials organized</li><li>闪购精选 Push-to-open doors create a sleek, h与le-free profile</li><li>闪购精选 FSC-certified wood 与 an anti-slip steel base add lasting support</li></ul>', 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_e6525b6402e21f66cfb8dabdeb07db40.jpg', 1, 1, '2026-07-14 16:02:46', '2026-07-16 20:33:27');
COMMIT;

-- ----------------------------
-- Table structure for t_spu_image
-- ----------------------------
DROP TABLE IF EXISTS `t_spu_image`;
CREATE TABLE `t_spu_image` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spu_id` bigint NOT NULL COMMENT '所属SPU',
  `image_url` varchar(256) NOT NULL COMMENT '图片URL',
  `sort` int NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `idx_spu_id` (`spu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=545 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品图片表';

-- ----------------------------
-- Records of t_spu_image
-- ----------------------------
BEGIN;
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (1, 1, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (2, 1, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (3, 2, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/05/30/0c694f385dd7a367313dd370bafad6b6.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (4, 2, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/05/30/0c694f385dd7a367313dd370bafad6b6.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (5, 3, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/4b0b14a657664fd3af6e1532724f60cf.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (6, 3, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/4b0b14a657664fd3af6e1532724f60cf.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (7, 4, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fbf22777ba8014774a7d61221af4cb212_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (8, 4, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/uploads%2Fbf22777ba8014774a7d61221af4cb212_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (9, 5, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/wms/product/img/productImg/2021/05/06/fd5ff30ea0554547b57da90d9ddc6e4e.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (10, 5, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/wms/product/img/productImg/2021/05/06/fd5ff30ea0554547b57da90d9ddc6e4e.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (11, 6, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fcc5dd61cbe6b41f482ee0959f0bffeda_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (12, 6, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/uploads%2Fcc5dd61cbe6b41f482ee0959f0bffeda_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (13, 7, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/09/14/2500x2500_79bf6b008d781edac094b4fdc0dfd755.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (14, 7, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2024/09/14/2500x2500_79bf6b008d781edac094b4fdc0dfd755.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (15, 8, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/27/7f6a9624949e4870e23a1da143d7cceb.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (16, 8, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/04/27/7f6a9624949e4870e23a1da143d7cceb.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (17, 9, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/03/2e0d695ae4664a42a95d6cb1f94c950d.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (18, 9, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/06/03/2e0d695ae4664a42a95d6cb1f94c950d.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (19, 10, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/15/1aa9ad85dcd0c6f74eaa9c99a925c6de.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (20, 10, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/06/15/1aa9ad85dcd0c6f74eaa9c99a925c6de.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (21, 11, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/2/2024/07/01/1000x1000_0ad19df4b4d5d01dd5e78042b6e4d170.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (22, 11, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/2/2024/07/01/1000x1000_0ad19df4b4d5d01dd5e78042b6e4d170.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (23, 12, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (24, 12, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (25, 13, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/07/14/2500x2500_2efb74b9e064bde39e004a495d93a0f1.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (26, 13, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/07/14/2500x2500_2efb74b9e064bde39e004a495d93a0f1.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (27, 14, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/23/bdbf00f468a8ded51650f8f0e5c4a674.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (28, 14, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/03/23/bdbf00f468a8ded51650f8f0e5c4a674.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (29, 15, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/08/26/0e579b525f16e750f48ccb05ffc20ad3.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (30, 15, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/08/26/0e579b525f16e750f48ccb05ffc20ad3.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (31, 16, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/644fd3682400434aa1ec7a6a29900252.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (32, 16, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/644fd3682400434aa1ec7a6a29900252.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (33, 17, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F2d2c3c56ae4a44819976e966896e3904_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (34, 17, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/uploads%2F2d2c3c56ae4a44819976e966896e3904_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (35, 18, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/08/08/2500x2500_c616918017879636c0b2ccffedf77ce2.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (36, 18, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2024/08/08/2500x2500_c616918017879636c0b2ccffedf77ce2.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (37, 19, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (38, 19, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (39, 20, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/03/11/1600x1600_6c395b3c5665e9ac5f061a522a8087d8.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (40, 20, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/03/11/1600x1600_6c395b3c5665e9ac5f061a522a8087d8.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (41, 21, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/27/722b5dd9eebda38eb5e9121c48899bcf.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (42, 21, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/03/27/722b5dd9eebda38eb5e9121c48899bcf.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (43, 22, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/13/72c2e93e838e93ed36f06b5a41aca0cf.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (44, 22, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/11/13/72c2e93e838e93ed36f06b5a41aca0cf.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (45, 23, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/21/2500x2500_390568db3b405673391efff11c946b67.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (46, 23, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/11/21/2500x2500_390568db3b405673391efff11c946b67.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (47, 24, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/10/2500x2500_a169a6d705d39dbdeaf45fad7b859ed4.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (48, 24, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/09/10/2500x2500_a169a6d705d39dbdeaf45fad7b859ed4.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (49, 25, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/27/8fa9bfbe10824bd95f98539b8609b067.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (50, 25, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/07/27/8fa9bfbe10824bd95f98539b8609b067.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (51, 26, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/10/29/9712e0285ca942f28cbeaddea5203bda.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (52, 26, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/10/29/9712e0285ca942f28cbeaddea5203bda.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (53, 27, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/26/2500x2500_3e72594537a1b2436f2f0c09030daa24.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (54, 27, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/08/26/2500x2500_3e72594537a1b2436f2f0c09030daa24.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (55, 28, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (56, 28, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (57, 29, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/25/531dee4e99fe450eed268805c684f701.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (58, 29, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/03/25/531dee4e99fe450eed268805c684f701.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (59, 30, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/07/27/d3a6fb58aca147b6aa12dfd9db6783b6.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (60, 30, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/07/27/d3a6fb58aca147b6aa12dfd9db6783b6.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (61, 31, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F4a7aa93485444f66ad6c996a1d42d970_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (62, 31, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/uploads%2F4a7aa93485444f66ad6c996a1d42d970_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (63, 32, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/01/28/2500x2500_40540d7c99ff2290e216b48fd934abf5.png', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (64, 32, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2026/01/28/2500x2500_40540d7c99ff2290e216b48fd934abf5.png', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (65, 33, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/05/2500x2500_e6f5ae35807bf8158e19d26e692d9f7a.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (66, 33, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/11/05/2500x2500_e6f5ae35807bf8158e19d26e692d9f7a.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (67, 34, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/04/29/2500x2500_c1a66af6c2eb3384c6f037fbfd4ab675.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (68, 34, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/04/29/2500x2500_c1a66af6c2eb3384c6f037fbfd4ab675.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (69, 35, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/25/2c28f7b491e2a037208a46e80e1b528c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (70, 35, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/05/25/2c28f7b491e2a037208a46e80e1b528c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (71, 36, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/09/29/2500x2500_dc1af8279a54b865078420a9e828997c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (72, 36, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/09/29/2500x2500_dc1af8279a54b865078420a9e828997c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (73, 37, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/09/27/7d2710a09ff57e8f8484003b97f6eb39.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (74, 37, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/09/27/7d2710a09ff57e8f8484003b97f6eb39.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (75, 38, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/07/07/2ca54b65d3770c8f0d4d112e37333e0b.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (76, 38, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/07/07/2ca54b65d3770c8f0d4d112e37333e0b.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (77, 39, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/06/26/2500x2500_3aa75149afca2776814b28dafe67d83a.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (78, 39, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2026/06/26/2500x2500_3aa75149afca2776814b28dafe67d83a.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (79, 40, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/30/bb3329c26145543a2e8af12e30683f15.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (80, 40, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/03/30/bb3329c26145543a2e8af12e30683f15.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (81, 41, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/26/b8d71ef80aa9a272cd99b68439108356.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (82, 41, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/07/26/b8d71ef80aa9a272cd99b68439108356.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (83, 42, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/11/10/2500x2500_902010c380fcee94f93df189f2ca3f86.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (84, 42, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2024/11/10/2500x2500_902010c380fcee94f93df189f2ca3f86.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (85, 43, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (86, 43, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (87, 44, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/08/08/588259821cbecc99978d252ce7f65d02.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (88, 44, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/08/08/588259821cbecc99978d252ce7f65d02.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (89, 45, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/5bbded0f665f4722abca0e894a3d447c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (90, 45, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/5bbded0f665f4722abca0e894a3d447c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (91, 46, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/05/20/9593fceb25846cfee5584b82913f9dbd.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (92, 46, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/05/20/9593fceb25846cfee5584b82913f9dbd.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (93, 47, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/04/23/2500x2500_9018865b20885a317875b2c28f11de1c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (94, 47, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/04/23/2500x2500_9018865b20885a317875b2c28f11de1c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (95, 48, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/08/19/1000x1000_9f7d6813fea1127808a03efefefd4079.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (96, 48, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/08/19/1000x1000_9f7d6813fea1127808a03efefefd4079.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (97, 49, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/60fef9a124f244428757b3520d41df3c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (98, 49, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/60fef9a124f244428757b3520d41df3c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (99, 50, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/29/501c65f11d5ac44f2fca3e5596d271be.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (100, 50, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/07/29/501c65f11d5ac44f2fca3e5596d271be.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (101, 51, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (102, 51, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (103, 52, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/14/bc4c4758dec573376b35cfaebdfccbea.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (104, 52, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/11/14/bc4c4758dec573376b35cfaebdfccbea.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (105, 53, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/wms/product/img/productImg/2021/05/05/884abe5502c14223b84105f950e762e4.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (106, 53, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/wms/product/img/productImg/2021/05/05/884abe5502c14223b84105f950e762e4.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (107, 54, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/d550804b53eb440a8881aa572b15b9ad.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (108, 54, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/d550804b53eb440a8881aa572b15b9ad.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (109, 55, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/07/31/2500x2500_6bbd99a408bab353919c6f4737bf6462.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (110, 55, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/07/31/2500x2500_6bbd99a408bab353919c6f4737bf6462.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (111, 56, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/07/12/4b2a448a6fec46fa9d699df82fa9c4cb.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (112, 56, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/07/12/4b2a448a6fec46fa9d699df82fa9c4cb.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (113, 57, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/17/a51e2aaf1f7eb1123ff317c2918c8224.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (114, 57, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/05/17/a51e2aaf1f7eb1123ff317c2918c8224.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (115, 58, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/10/23/9e0f37a7886bdf2ccb4149b515b42a54.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (116, 58, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/10/23/9e0f37a7886bdf2ccb4149b515b42a54.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (117, 59, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/26/bcd3dd5dfe918c480753acc96d986f98.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (118, 59, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/07/26/bcd3dd5dfe918c480753acc96d986f98.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (119, 60, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/22/2500x2500_92f82fbba644c5b9732aaf02e0757e5f.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (120, 60, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/01/22/2500x2500_92f82fbba644c5b9732aaf02e0757e5f.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (121, 61, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/02/27/2500x2500_0f36ed3c36e27d1ed14e8edc49681178.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (122, 61, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/02/27/2500x2500_0f36ed3c36e27d1ed14e8edc49681178.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (123, 62, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/05/23/88c27ecfe9bac0be38eb0ad007a00e96.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (124, 62, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/05/23/88c27ecfe9bac0be38eb0ad007a00e96.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (125, 63, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/09/d2e1911c6d724f578bd0eba683d8dab2.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (126, 63, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/09/09/d2e1911c6d724f578bd0eba683d8dab2.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (127, 64, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2Fcf76038f7a16495e8d5de21b991a7ddc_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (128, 64, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/uploads%2Fcf76038f7a16495e8d5de21b991a7ddc_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (129, 65, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/09/26/fcc8ccf7c68b9814975fc7960e7d0cd9.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (130, 65, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/09/26/fcc8ccf7c68b9814975fc7960e7d0cd9.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (131, 66, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/07/29/7be5fb1a45cef4332f69e14e8be33945.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (132, 66, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/07/29/7be5fb1a45cef4332f69e14e8be33945.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (133, 67, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F755329f3ef014e259d9d0c81787c228e_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (134, 67, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/uploads%2F755329f3ef014e259d9d0c81787c228e_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (135, 68, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/01844ec6b8bb40049acd4925b76cc63c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (136, 68, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/01844ec6b8bb40049acd4925b76cc63c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (137, 69, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/07/8a48b0c3e1562fd4ee2486b323d59f06.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (138, 69, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/03/07/8a48b0c3e1562fd4ee2486b323d59f06.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (139, 70, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/f567815bd81b4251a900cd3baaa9d70f.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (140, 70, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/f567815bd81b4251a900cd3baaa9d70f.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (141, 71, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/05/07/2500x2500_35541486a748d42f93d38c9b07f46323.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (142, 71, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2026/05/07/2500x2500_35541486a748d42f93d38c9b07f46323.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (143, 72, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/12/02/2500x2500_7193d4eb29d00639ce4275b3ce21e8f9.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (144, 72, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2024/12/02/2500x2500_7193d4eb29d00639ce4275b3ce21e8f9.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (145, 73, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/11/15/21de367270881061e9ce649785b13bd8.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (146, 73, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/11/15/21de367270881061e9ce649785b13bd8.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (147, 74, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/12/18/4000x4000_f2b601f5d5f1512a167ed67bb2dbcadf.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (148, 74, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2024/12/18/4000x4000_f2b601f5d5f1512a167ed67bb2dbcadf.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (149, 75, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/4a00ce43fb284625b34d3e711d661f40.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (150, 75, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/4a00ce43fb284625b34d3e711d661f40.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (151, 76, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/08/2378195d9ee846ba3989b7f4a2cf2d47.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (152, 76, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/06/08/2378195d9ee846ba3989b7f4a2cf2d47.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (153, 77, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/12/10/2500x2500_c0b24aaa4672fe5fbf79b9b7425b32ff.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (154, 77, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/12/10/2500x2500_c0b24aaa4672fe5fbf79b9b7425b32ff.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (155, 78, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/05/30/2500x2500_f4636b0ab9308d0ecea8111937f84f1a.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (156, 78, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/05/30/2500x2500_f4636b0ab9308d0ecea8111937f84f1a.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (157, 79, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/uploads%2F99f5b65c3f8a452c90dc1a5481ca4f1b_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (158, 79, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/uploads%2F99f5b65c3f8a452c90dc1a5481ca4f1b_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (159, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/05/28/4d93f3f75d6ef1a1a00259b1ddbac28b.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (160, 80, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2024/05/28/4d93f3f75d6ef1a1a00259b1ddbac28b.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (161, 81, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (162, 81, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (163, 82, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/10/7da227f77cc34d5da746fccda100191e.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (164, 82, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/06/10/7da227f77cc34d5da746fccda100191e.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (165, 83, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/common/2022/03/29/e552950b71708f93114f11d0806bb759.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (166, 83, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/common/2022/03/29/e552950b71708f93114f11d0806bb759.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (167, 84, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/01/993dcd6b692760bdcac5191a770dbf0c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (168, 84, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/06/01/993dcd6b692760bdcac5191a770dbf0c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (169, 85, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/07/2500x2500_5e1fe90b2db1ff5ce3a871cb37b960ee.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (170, 85, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/11/07/2500x2500_5e1fe90b2db1ff5ce3a871cb37b960ee.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (171, 86, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/30/f6d73ab6ebaf02a68b1f3e3eb4aa7b4d.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (172, 86, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/04/30/f6d73ab6ebaf02a68b1f3e3eb4aa7b4d.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (173, 87, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/24/cce35a47474684b0328023b6d9555310.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (174, 87, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/03/24/cce35a47474684b0328023b6d9555310.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (175, 88, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/06/04/5598539a27064a3e8af5438d2db11422.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (176, 88, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/06/04/5598539a27064a3e8af5438d2db11422.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (177, 89, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2022/06/13/a3f87666be6941f09269e4b8c40a84b9.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (178, 89, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2022/06/13/a3f87666be6941f09269e4b8c40a84b9.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (179, 90, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/29/fa585b6f31cfd0824946663bc7dd055d.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (180, 90, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/04/29/fa585b6f31cfd0824946663bc7dd055d.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (181, 91, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/11/21/2500x2500_54f9d36af129d803adcd415767462c11.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (182, 91, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/11/21/2500x2500_54f9d36af129d803adcd415767462c11.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (183, 92, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/10/24/f81de2732e038c7a0c4add9b5c7a2a2d.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (184, 92, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/10/24/f81de2732e038c7a0c4add9b5c7a2a2d.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (185, 93, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2024/08/27/2500x2500_5425251dfd2fac03dd2866c01054ec78.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (186, 93, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2024/08/27/2500x2500_5425251dfd2fac03dd2866c01054ec78.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (187, 94, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/04/07/6b6f8b1bcb9d4313c81f884ad2761c1f.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (188, 94, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/04/07/6b6f8b1bcb9d4313c81f884ad2761c1f.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (189, 95, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/02/3000x3000_4730eb64fc61a5a912dba793748d2360.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (190, 95, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/01/02/3000x3000_4730eb64fc61a5a912dba793748d2360.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (191, 96, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2025/01/02/3000x3000_1a06d432aae9a1014c9aaca43fddad43.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (192, 96, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2025/01/02/3000x3000_1a06d432aae9a1014c9aaca43fddad43.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (193, 97, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/2021/04/06/c008ab29e13d40089136537901b9f83b.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (194, 97, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/2021/04/06/c008ab29e13d40089136537901b9f83b.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (195, 98, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2023/03/28/e9007f79ae2b2d8b3d791409f2c1e30e.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (196, 98, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2023/03/28/e9007f79ae2b2d8b3d791409f2c1e30e.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (197, 99, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2021/09/22/a90109d094b64127b089e68b353ef625.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (198, 99, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2021/09/22/a90109d094b64127b089e68b353ef625.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (205, 100, 'https://img5.su-cdn.com/cdn-cgi/image/width=750,height=750/mall/file/2026/05/21/2500x2500_eb75b5a609a45e2c5a715d1547a0002a.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (206, 100, 'https://img5.su-cdn.com/cdn-cgi/image/width=400,height=400/mall/file/2026/05/21/2500x2500_eb75b5a609a45e2c5a715d1547a0002a.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (207, 100, 'https://media-local-s3.s3.us-east-1.amazonaws.com/growth/dev/2026/07/14/39dd1844face4d2dafcac9c133133d21.webp', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (208, 100, 'https://media-local-s3.s3.us-east-1.amazonaws.com/growth/dev/2026/07/14/48f09a2daf5d44898a1349658e5572c6.png', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (209, 2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_68018454ad18e690bce4b73791d09d1b.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (210, 2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_3094a083fb29f5c6c038919bd98f54e7.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (211, 2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/10/2500x2500_be5c73cf98c52ca552972f0d6f627df5.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (212, 2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/3000x3000_a40719ca8719ffe2404d2185d99b6464.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (213, 2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/3000x3000_dc1edbc61c7e5f5387e4dc207f7d0b08.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (214, 2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_af368378b3a76f4c2d5f437986e8dc8e.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (215, 2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/3000x3000_9ab53ef0701abb4439a7f79993581042.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (216, 2001, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_3ddcc0e2c2a61d1bb3b671b38b71a5dc.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (217, 2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/30/2500x2500_563885afd3a8fad87e374fb6d2743819.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (218, 2002, 'https://img5.su-cdn.com/mall/file/2024/09/03/5c4b95e4c9d4f78df8df53626d5287c6.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (219, 2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/07/2500x2500_d746723e3d1a1b6ca98f59ace0a040ca.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (220, 2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/28/2500x2500_ac512150521dbc9a52e3437fdc83bff9.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (221, 2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/28/1500x1500_bb6c09a223632878028becbf5473107a.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (222, 2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_645a71e866934953fb50a6a6d939f808.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (223, 2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/05/25/2500x2500_a219b42398a7c956cd1c2e6aab01f44f.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (224, 2002, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/16/2500x2500_0aa12a2b4ba978696e56d90f926a63b9.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (225, 2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_4ef15a358018b1ad9f882794802b45b3.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (226, 2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/05/14/339d705611a2d6b7374b1b8ad0939c7e.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (227, 2003, 'https://img5.su-cdn.com/mall/file/2024/05/17/1353d11c73c6ef46a42fea5cf46a0d48.mp4', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (228, 2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_3db13eb227bf5be2e79fa11a3c2b0be2.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (229, 2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_07c803e4c6ff787843460220516d36bd.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (230, 2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_32533b101cf04bcce44fb0704ffb0071.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (231, 2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/02/2500x2500_bce6ca472d04bcb9b43c049b25ba044d.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (232, 2003, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/29/2500x2500_ec71045a7886738a15c36f2423ef3d0a.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (233, 2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_776c68b2df6c5982e6f8940dc554d301.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (234, 2004, 'https://img5.su-cdn.com/mall/file/2025/09/18/64062048e0eec36411ac265a4adcd01e.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (235, 2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_049823d50a0dccb34d8bf715b154fb09.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (236, 2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_cd377f94b6e86b726451273f3dd4ebdf.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (237, 2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/29/2500x2500_61c7595923570ec76ab03e9e832224db.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (238, 2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2Fa8f03b4e1f2e4c59a7ffcf22a0ad45bb_.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (239, 2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/06/2500x2500_22ad4c0081b4d93bdd6d357c279bcc7c.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (240, 2004, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/28/2500x2500_2b0d963bd6c11d84eedd6a615964ab11.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (241, 2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/10/10/ca2b2248d9f08dac420975b5b2761632.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (242, 2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_c95b942e70a3a6d37a7961aab902691a.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (243, 2005, 'https://img5.su-cdn.com/mall/file/2024/05/29/98c6bfee71207d5495bbb8eb78b77c9e.mp4', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (244, 2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_7c4b5c026c6b8c0d021acd114854b9d0.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (245, 2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_73c13385a48d683932ef3210db3677b8.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (246, 2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/16/1600x1600_082d50d94631b29fd32919156b66269c.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (247, 2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_09d8f19cd0936c8d3ea31d132b1b0c0c.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (248, 2005, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/10/2500x2500_e8a26bbcc85e2849462dd2ba09fc8bf0.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (249, 2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/ad7d891b853f1eda6eedb43a14a1bc63.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (250, 2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/970cd7877e8367fcb005aab248383b5c.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (251, 2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/27/2500x2500_7a5fe481f4667655cba2da9b686d671b.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (252, 2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/11/4e258cf592a2b7e419619192619e393d.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (253, 2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/11/14a8062bf9716da145dfbcffd132e515.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (254, 2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/02/7f888bf8bded9200623ffd10adf60471.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (255, 2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/11/887f51987e67f4ec9f2b2010e508311c.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (256, 2006, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/05/31/cba44c3d47ca5b6176673e62f6b3a0e6.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (257, 2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_d381d45f3b2b3f52b2913af302cef9d0.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (258, 2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/2500x2500_3d0b41129fd78b68b6fa218b3549f2f9.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (259, 2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/2500x2500_3ae6dde7d14120ed18729f87e7df50dc.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (260, 2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/25/2500x2500_db6c18d39095fb10a3482f74c11b5bf3.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (261, 2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_4e7a581d12e79d234a238d21bcc5e17b.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (262, 2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_44001a09ae23f640dba7896b837663ca.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (263, 2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_2da31891069e6bfe54fe1054ec7cc214.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (264, 2007, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/21/2500x2500_81dc10cc5b3af9d2cf2531224d8c5489.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (265, 2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_8bd9e87f49e2482713fc3ab7f482bcc3.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (266, 2008, 'https://img5.su-cdn.com/mall/file/2024/09/12/8481e3d1b55201d57b3ba381bf6a6a60.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (267, 2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/09/20/2500x2500_92d1d2655b846f2ab1e99d8385e5f2bd.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (268, 2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/08/2500x2500_222d1b241a43524424f710193e697d9a.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (269, 2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/21/2500x2500_9d306a08c63b6736af2d5421e4df35b1.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (270, 2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/05/2500x2500_d477825dca1f73fd6965af6e20744705.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (271, 2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/04/29/4f274228e034fb4f64c03b7e2dfb864a.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (272, 2008, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/08/2500x2500_2f94b037d55cb6aa9eca59d8c7d4c650.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (273, 2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/06/03/7aef181a1ba049c2bffe4341ab23b8be.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (274, 2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/05/17/596f966d8392d06c289e6ae063827014.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (275, 2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/07/66a27221d50f495dab9effc2b04c1094.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (276, 2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/07/e208dd18318067a9ba77bd15debddfde.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (277, 2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/05/64b5263fcd4dcea449dd352801de6944.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (278, 2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/08/08/56a6d6f6f0a538ec8465970a76c658d2.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (279, 2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/23/72f0222ed94dcd920f55fd96e01408e0.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (280, 2009, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/05/159216cb1392a95b6f4d19d58dbf5f29.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (281, 2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/9fbc03b404081fe1d1051daa11c0b1ef.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (282, 2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/f95cc47fa9c2c3dec08aa223c72e2ea2.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (283, 2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/37086c29e029ec2c3b0c1558f5bbc81b.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (284, 2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/06/02/dbd9866ecd710ad29cafbbbedcc5c2f3.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (285, 2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/17/2500x2500_e41754d0f0e16a6e3ad881d25d23d167.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (286, 2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/05/1000x1000_e0c01adadedf5449514fbc68e064326e.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (287, 2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/17/2500x2500_c5cff504466b3eb7ac3f7e79b2b1cb4d.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (288, 2010, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/27/2500x2500_238cf64c9a3e6dae06d405545b756a17.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (289, 2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2021/09/29/312aab8a43d2452398f8c461cadea79c.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (290, 2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/09/2500x2500_36933681c4031f1c5d29d0636703ea6a.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (291, 2011, 'https://img5.su-cdn.com/mall/file/2024/08/07/5f43a4732b63d34423b5f6752a1b3edc.mp4', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (292, 2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/09/2500x2500_b003a2a250930cacb7110cbf6437f35c.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (293, 2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/25/1000x1000_231474df6f1dc9ca824e9b9057930171.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (294, 2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/09/2500x2500_e8bfcc06ba4a50e855f3ad7309dddbde.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (295, 2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/09/2500x2500_bc1b240d0e8070878427454f3721bef9.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (296, 2011, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/04/1000x1000_46c70421fbb89e153892f6cf5a46ac9f.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (297, 2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/1600x1600_d441d16a02baa02b59a4c2a9fa071edc.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (298, 2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/2500x2500_b6182735226188dd0d8f69ef34900b06.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (299, 2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/17/2500x2500_f77beb960d3b240bc7721b674ba51b4e.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (300, 2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F97ad12642fed4c7080ad1b2461d456b4_.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (301, 2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/12/2500x2500_aab38927c84a26d48ce7f67492f69e34.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (302, 2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/12/2500x2500_e1998d372b245328967cbd46b218b947.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (303, 2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/12/2500x2500_b56cd8a3ad06a4f46c7b8251ff51cf9d.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (304, 2012, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/12/2500x2500_de52b2fbc4197a5ff59abeeb91f0ea74.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (305, 2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F4dbcf8ad6a4949639f30536645394236_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (306, 2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2Fdb741e8c54bf468a88e299a89468d40e_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (307, 2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2Fa079e76159424581b6b43927a6443c9d_.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (308, 2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/24/2500x2500_0b305226115c671d3d4ebe5a4ad91f33.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (309, 2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F30285e4590334fe7ad73573859d2f6b0_.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (310, 2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/05/14/2500x2500_3d2f3622b26516d0295d33d3ca1abe41.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (311, 2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F8d40c0eb85134fe1bcb0203a92444f24_.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (312, 2013, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F6dd113cdab3b48558b5b497307ed0db8_.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (313, 2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_caa12179501f6477a44ca058cb61d66b.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (314, 2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_192876324e63edaf20ab9b7e6f0ffca0.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (315, 2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_dbb10e6aeeb2e75a9723630018dcad0e.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (316, 2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_c7c8a1f51734b2b694b4c413092000af.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (317, 2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/5000x5000_4c8cbdf052330bda7126583b83ea89a8.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (318, 2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/2500x2500_42940d3fd15016e0044a369e962389eb.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (319, 2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/13/2500x2500_001777e289ff12a78dfa4f26f230dce7.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (320, 2014, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/15/5000x5000_17eccee545c9da97af9e3fe9ca8a4ce6.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (321, 2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/1f3bc4195f48b9305df8370fdbc87550.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (322, 2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/2768d37e4636f4419f10f07aa5e6a1c4.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (323, 2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/e7fbfb52c78092122d8db4493fcb6aed.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (324, 2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/55eebc431881eed94751487f2376c12b.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (325, 2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/11/30/81fd466ebc30f8b3c52fa281856774bb.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (326, 2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/17/2500x2500_5be6248f205253d50297aebeed06ef54.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (327, 2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/08/09/9abdde37f6f2be0b47eefca6c7689a36.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (328, 2015, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/08/09/84f79d24b713a1dbdc674f995f0dc5f2.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (329, 2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_562a03bcaece63c7d0ce6cc5d6dea758.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (330, 2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/06/2500x2500_f54c22946b2bbf2d558c25c4fa18add7.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (331, 2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_bd5d433b732ed37d0bce8de7e21d210d.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (332, 2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_3df74fcdb2e17daa947f0ec1182b53aa.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (333, 2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/08/2500x2500_e6689bd1a6b63b050b70f8de78cc5f85.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (334, 2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/08/2500x2500_7688be5462c76c6cd4be5679b6b83ba5.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (335, 2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/11/1000x1000_7c2f081869dbc5db342bb2daf8ed83ab.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (336, 2016, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/21/2500x2500_23926cd99d6a8e704f5987b304a89d12.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (337, 2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/09/13/2500x2500_09241c4786edb7e197e5b3ba220f8362.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (338, 2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_2161d3874793806b412050732dafed7f.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (339, 2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_921e15444c8b861c85520d9e33e14f1d.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (340, 2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_f46e4ac27079f2e78cf77f08f3b47784.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (341, 2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_7cd040a4402e7905d4150407e058fdc8.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (342, 2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/3000x3000_7f25974ec56364e9af6e738371ef609c.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (343, 2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_a5a61532823862fb75581dfaa4522b0a.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (344, 2017, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/23/2500x2500_b4e85e6146594adf66437dfb23d1ccdf.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (345, 2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_ba661f0bcb8f8633e675b2e19034dca5.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (346, 2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_d650c6c97a2eb2358efc7401410d5b41.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (347, 2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_83c3ee7816bfa8c4198327b11876610a.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (348, 2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_7a5b8da58208eb30527455419aac6728.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (349, 2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_1fa6a8b3113cd23786d0217106fce39e.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (350, 2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_ba21f70dded5e7a54311bc154be2d570.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (351, 2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/02/11/2500x2500_0097fb57c85cf57189126e75e3e31b79.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (352, 2018, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/05/29/85a0ed0c7b34aa60b56a2e6be77f68f4.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (353, 2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/a891337a4dd015aa12e8f002336146e0.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (354, 2019, 'https://img5.su-cdn.com/mall/file/2023/11/10/bbae9bdb56cb4b01ef5628c174dbbcf6.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (355, 2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/692c504c97b96d2c3753ab4d61226432.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (356, 2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/b4d97167f3d66147aaac3a79b71c434c.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (357, 2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/02fb2cef8bc2ed13460fa86f26f0cd38.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (358, 2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/a63aa874cd64463073484b705ec863f4.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (359, 2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/2/2024/06/28/1000x700_30f877255f61834b4cb4dc67c48c0fe4.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (360, 2019, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/30/4946ed750021e4435aa02fef4049c2d4.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (361, 2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/fba84dd2c9c3a805a2a3316380633cc6.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (362, 2020, 'https://img5.su-cdn.com/mall/file/2025/05/15/721a815d19230e1b53e2ba8862b2888c.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (363, 2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/bd36e32dde14e6ff855619da735c66d7.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (364, 2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/12/14/18a2b1bf4330798017d74cf7242d96e5.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (365, 2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/13/2500x2500_0ae590fb5c3dc2b90d4b26d28e27d595.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (366, 2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/05/2500x2500_f227850e0b747fd0d242f3f28dfa4a25.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (367, 2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/23/2500x2500_5d8363115490400fd0cc0f2920f246c4.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (368, 2020, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/04/23/2500x2500_147f461220acd66b137c8c88551822c1.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (369, 2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/10/09/a4792d81b5516d1936feacb64bb0ccf1.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (370, 2021, 'https://img5.su-cdn.com/mall/file/2024/01/16/8a565d4e27420356a4ec60170f56dcde.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (371, 2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/14/2500x2500_13f20a77beb3085e86d0d8928334d811.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (372, 2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/14/2500x2500_edccdfa0e8a99b4f2ac977197b61d40a.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (373, 2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/14/2500x2500_5c9bcf1a4b210912bacc03dbad74a905.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (374, 2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/27/2500x2500_bf15815ba81e5b5d973e3e4cf1cb8df7.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (375, 2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/25/2500x2500_0a354a693d31b5a7337c621789ebd22c.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (376, 2021, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/27/2500x2500_ca056ef6d24b55874c34023732dbd4c2.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (377, 2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/14/547b4c7517cd46a16dd5d244f2b33b54.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (378, 2022, 'https://img5.su-cdn.com/mall/file/2022/12/02/08de99f62f339829fb31854e4fec39b1.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (379, 2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/10/1500x1500_aa298202caee8032337f8b37743430dd.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (380, 2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/01/1a43134662acfc4cb8bec51b09186bd5.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (381, 2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/09/14/0b5b41ef8a56dc9c020c41dd09e249bb.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (382, 2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/01/5c0e8dbb6066ad4ea203a0b6cbb84378.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (383, 2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/29/2500x2500_5aba18f02b1254443d9e5576c670c694.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (384, 2022, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2022/07/01/d3ba83f6374d527819b165590b1aa653.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (385, 2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_40c7a88c6f05da177ab46134f1839019.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (386, 2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_1bcd9843f9f2eb68e7a129162ab20721.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (387, 2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_98d46646a4fbcfff06f84dc38564b84e.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (388, 2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_1429f33a67ec8708e28dc09eb9b84e7f.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (389, 2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/10/2500x2500_65559eb3ffb30999a37f4dbb37a5d006.gif', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (390, 2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/06/30/2500x2500_ca601c53d7b4ca6a76656ef1712c0d5e.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (391, 2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/10/2500x2500_bda98d7b8e34edb11bf44e3f76d8add2.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (392, 2023, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/10/2500x2500_00516e3792b287101649aba94d7af914.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (393, 2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_8416f1e292d7a52bc8795322a554e6c8.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (394, 2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_5b152e78f6a507f8382686fb0a235eca.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (395, 2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_53149ed84c2ca6979d505d5a0b68d2ce.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (396, 2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_c5229094144cb74e0ec7bbc3842fb291.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (397, 2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_b4d38a91d590af46b110e9773a7b0883.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (398, 2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/05/2500x2500_7a29028e712242ced3fc60f1063951cc.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (399, 2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_765eb7408f8567f6cd08e1698fe7c796.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (400, 2024, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/22/2500x2500_9ff3c4fa38538eabf19a78a229116a61.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (401, 2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/4096x4096_e88371d883ecaf8325aee489e48f3220.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (402, 2025, 'https://img5.su-cdn.com/mall/file/2026/01/20/4f4838e44a9c29754af8b0c6170c373e.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (403, 2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_63b99e5bd8ce8a475c765ca8b34f9884.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (404, 2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_879ac88aa3cc07274c192054d0df1890.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (405, 2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_244f90ae55fff24492ebd8bd277871e2.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (406, 2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_e13bff1c61bfb53f67eb15a40eb16e9e.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (407, 2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/11/2500x2500_53261b54a43edd0a6c4e6724606a4ff8.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (408, 2025, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/15/2500x2500_61ad5f414fbd094f42fb2f2b682185d3.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (409, 2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_c650adc2c9ffb688f8110be953c11b90.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (410, 2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_e134302d00f171d0e008b2165921e867.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (411, 2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/27/2500x2500_c52e5d4fd6ea2dbe8f0b1ebac1eb546e.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (412, 2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_e7f5d12ca236f25b2af4000caf7eb39d.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (413, 2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_e5d998a7df966d9fe8534090256c3bb2.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (414, 2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_5083a07d09473af4407dc81c294e2f8c.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (415, 2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_d9e41b4dd89a8b062aece7030958f7b8.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (416, 2026, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/06/18/2500x2500_8b04244e7e764e2247605c5a0feede3a.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (417, 2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_c8beca0ba8fb1cde333cf205affe07a6.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (418, 2027, 'https://img5.su-cdn.com/mall/file/2025/02/14/ab2a9723959c6193792a4ef6091cdf67.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (419, 2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_2467eca3bfaf5ca8dd6ee4e6a0582295.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (420, 2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2460x2460_21db4578eddc4688bf494da2f56abbd2.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (421, 2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_ad2eaced45d691d5a494ab2b09bd7f5a.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (422, 2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_041e2a11a20e4554e64b95a26b0eb73b.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (423, 2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/3000x3000_48abb34c8a07ab5908fad9db158ff0f4.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (424, 2027, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/23/2500x2500_b6021b6a81ce5da1c8466ae342683d48.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (425, 2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_ea17eff6265eef031a9e744b59401d72.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (426, 2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_9f56f07329945c917b71e06b85ebecbe.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (427, 2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_db3d641d0c25844265fe6cbbd4fe8ba3.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (428, 2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/25/2500x2500_73763ca1c1be8daeb5e763de6d98a4b1.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (429, 2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_babd7409043946f5bdd5755541e5aeff.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (430, 2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/16/2500x2500_92cd4c585365079b73e56b44f47886cb.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (431, 2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_b99fe4299148176bb0c4d33803c3c944.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (432, 2028, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/20/2500x2500_661a710fd6086a57d0ecdbb237b6b521.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (433, 2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_f9e1630c9d1d0fa37e2a8afdc6be68aa.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (434, 2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_a2abd0ffbac1e360344521a214ef5ed0.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (435, 2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/21/2500x2500_20490fa69328d2095cba48d4bf036840.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (436, 2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_2d0e34148f5ae61b128447c5e19b1562.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (437, 2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/01/21/2500x2500_ebe531c0ece0eeca8556a8b8691be17e.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (438, 2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_f56b7afa709ec78c24cd1ad334d0c087.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (439, 2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_c10e1a42b3147f74e6d18485e9e64cae.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (440, 2029, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/10/29/2500x2500_0b4334f7be605d79061e262a0cff582b.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (441, 2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/25/2500x2500_13e80149379d6220493ee0e264608b6b.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (442, 2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_09165adc778096ae3e5d0053e007b2e4.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (443, 2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_d3dc5ed5904eff3bb4ade410c47c26d3.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (444, 2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_c4c1dcab5a275cf5c3afc51379c97978.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (445, 2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_b4ddd09b9f87999eaa18528c12d8c85c.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (446, 2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/11/27/2500x2500_50db8581f13d820ac55446d6548236d4.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (447, 2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/2500x2500_371a07709f0db0185d9eb268abcb7c8c.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (448, 2030, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/11/15/1000x1000_283431a47cf2e5511b3fab810702885d.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (449, 2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_c310ad7ee843c59e6d3c496917427212.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (450, 2031, 'https://img5.su-cdn.com/mall/file/2026/07/07/b5039c5d160bd1ffb02117b6a4600f17.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (451, 2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_3cf4c2fa8e350ba4ecd559e1eace4c54.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (452, 2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_98f732b3902bbefeca793168bb4960aa.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (453, 2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_a80dc2c26f1eb96d59b1d7d18851faf0.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (454, 2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_0595c8dfe4358b46d616f1bb9d5a168e.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (455, 2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_91dd2ac82f53a9d8c3fca8ba9636a75a.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (456, 2031, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/02/02/2500x2500_f661cfdbab29bf2f4ef0aba28435d77f.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (457, 2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/29/2500x2500_a02fa2c0b43987859f16ff5f6a82c519.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (458, 2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/03/18/2500x2500_cc95a988ce827b0e0228b8e9fe77de49.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (459, 2032, 'https://img5.su-cdn.com/mall/file/2024/12/05/d4fe2ec7c836e3d3a7c94e088d7c3cb9.mp4', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (460, 2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/29/2500x2500_07a0805fb38d3d132e4ff4a77b34433b.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (461, 2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/30/2500x2500_3e3beb35bb236b2f993059c9d3b3382f.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (462, 2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/30/2500x2500_ac5f888968c05f7680d20bf543ab2534.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (463, 2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/30/2500x2500_6655de490b5ecec472ab35d34e34b2dc.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (464, 2032, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/08/23/1000x1000_bd509c01884c2a80d4bb684e889d8813.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (465, 2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_99461adc541da999544be17f9f29e674.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (466, 2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_1910f16cb61d07583e1601e151d0496a.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (467, 2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_66f143ff6a1c815373d7d12cd774bfb3.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (468, 2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_6699e7fe716ba40bac85a7f0db4aef48.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (469, 2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_43fabbd9d64a2ff3ecf273829bfd6267.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (470, 2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_effb7316e67217018cd498fb8365d2b3.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (471, 2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/1000x1000_6a33c702b94f1d227eaaaf93129190eb.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (472, 2033, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/09/780x780_5fce3ee2c61d7029c5a18bab01320b23.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (473, 2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/09/1600x1600_2cd0ae20465f41f320da1d6b4101fd08.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (474, 2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_d430badc3648b154aff16bd46769c2ec.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (475, 2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_8f43c6644f94073802762f5d9babdbdd.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (476, 2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_edce8c2dd77d172991f57dea48408ea3.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (477, 2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_dbf76de6c5b7421e1163a498724f57c8.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (478, 2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/30/2500x2500_b0633d70c8b87f3bae58d5823f17b135.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (479, 2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/1600x1600_1de609d59a14db11fdef27c8c5bc5253.gif', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (480, 2034, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/04/2500x2500_a69ccc36e76d1465c1e18785ce18ab20.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (481, 2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/aee18aa35e9368a30339efb69488e7db.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (482, 2035, 'https://img5.su-cdn.com/mall/file/2023/11/10/e5fbb589ec619d19b49abc0b1e2b05a9.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (483, 2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/5919f0d917510a632268b369b6e61be4.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (484, 2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/866ed48ec488e69df6aa3d99425d9f42.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (485, 2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/06/07/16cb564ae04ba3f231d963b6353d69bc.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (486, 2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/08/2500x2500_0a520c233067e690775fe260ecddbb0d.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (487, 2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/04/19/0f5e47c8b76a7908513f86680c1e7dd9.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (488, 2035, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/10/14/1000x1000_7c456f29cacbefd24d54d17477874d86.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (489, 2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_21071fa7feb62ad532c7fe1283741f50.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (490, 2036, 'https://img5.su-cdn.com/mall/file/2023/07/07/fdbd52e0abf561a6e924de2d209bd3b9.mp4', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (491, 2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_954a9baae79f97d17e0e5c07c479eb10.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (492, 2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_7b2eb72d5ed66ccab6e1f2a0546993b7.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (493, 2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_785b0a761a21f0b798c8e51d54a8ce5c.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (494, 2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_07f4eb0bf76ee4368b84ea4fc0271a32.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (495, 2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/03/05/2500x2500_ecfc37e5066e9e96951109cfa7ced453.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (496, 2036, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/17/2500x2500_9cc21cae6bd257919d5e7425b12a3d39.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (497, 2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_dbc3adebd57965e5786c055992c93722.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (498, 2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_19540dcdedc9f616d86d44ac529932dd.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (499, 2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_054327913eb1e43e61e46c254f23ec6c.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (500, 2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/04/2500x2500_b1696e738886d87fd150577dfd2406e3.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (501, 2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_b41cd7665f1790e6c1b056320acaa05a.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (502, 2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/04/2500x2500_17daf53a182888dddca8053abdcd05ea.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (503, 2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_e47432941879455d1624e1700c6e7d75.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (504, 2037, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/30/2500x2500_46c31ad0c320e1495244adeea11e3731.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (505, 2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_946e42f9a119f2110178e6839060786a.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (506, 2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/07/14/2500x2500_88b8e0e4f79a8218bbe3efdb5569ad01.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (507, 2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_a83b1370f0c8aea398e148d427a387e2.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (508, 2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/05/14/2500x2500_3dc826ead2e973cfb35adfdfda08f8f9.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (509, 2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_fc7663754f4ad8afe540d7eaa9cf1073.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (510, 2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/09/25/2500x2500_6d1fcb0c2068d5cc3194edde7a5c56f6.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (511, 2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/12/25/2500x2500_73763ca1c1be8daeb5e763de6d98a4b1.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (512, 2038, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/04/30/2000x2000_1923097e5efb3a82190083a57f9a34e5.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (513, 2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_fb975dc166c10e23da4ab28783647699.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (514, 2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_ff8bd635b7477cc03f193b787e703941.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (515, 2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_c901d16e97b7f9cf3a85de244c7057d0.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (516, 2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/1000x1000_5f047d620f40e2a711ecdbeeeaafab25.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (517, 2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2023/10/09/c128102b7acdc9d4e8c228dc8f5fdf8c.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (518, 2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/08/08/2500x2500_757d3c220458627c2a36c7fb3d768a3c.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (519, 2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/2500x2500_5c6ad363caaaf14e88b7e3ce55f09082.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (520, 2039, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2025/01/10/2500x2500_21e5be40b3bf5d0ae7e458bf0f529a45.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (521, 2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F6b080a113c3048c7ad7e6ac555f79264_.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (522, 2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2Fb55f3139a4ea44ab84908cc12aef1622_.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (523, 2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F228f06a6ff8f47afaad80d91ebff4b1d_.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (524, 2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F00c42f3100cf482a9e00fe359061d3f8_.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (525, 2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F1359373eba3b4c39806a7edf2923cead_.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (526, 2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/05/01/2500x2500_95344d7699902058358516de858f7c35.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (527, 2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/uploads%2F0a7741808e35479ab06e23bfdffe4074_.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (528, 2040, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/05/01/2500x2500_d86247d13690b408b8f49fa078df3cb5.jpg', 7);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (537, 2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_e6525b6402e21f66cfb8dabdeb07db40.jpg', 0);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (538, 2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_5ed7a8c451fe656370110852a26c0869.jpg', 1);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (539, 2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_cf1af3c4df5ece3d16891e4ffdea79d0.jpg', 2);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (540, 2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_821b86cfb43691000bdccdc01a6bfd0a.jpg', 3);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (541, 2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_2ea8dd146de9768dd61867c808e019b8.jpg', 4);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (542, 2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/08/2500x2500_44ead8120efb3c4cb2d9b0847d0dfa4a.jpg', 5);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (543, 2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2026/07/08/2500x2500_f11f468f055bb84077dc8d128eca5ba7.jpg', 6);
INSERT INTO `t_spu_image` (`id`, `spu_id`, `image_url`, `sort`) VALUES (544, 2041, 'https://img5.su-cdn.com/cdn-cgi/image/width=800,height=800/mall/file/2024/12/20/2500x2500_68b19284cbcd8c8bc414ebaf4c753b1f.jpg', 7);
COMMIT;

-- ----------------------------
-- Table structure for t_spu_spec
-- ----------------------------
DROP TABLE IF EXISTS `t_spu_spec`;
CREATE TABLE `t_spu_spec` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `spu_id` bigint NOT NULL COMMENT '所属SPU',
  `spec_name` varchar(32) NOT NULL COMMENT '规格名',
  `spec_values` varchar(512) NOT NULL COMMENT '可选值，逗号分隔',
  PRIMARY KEY (`id`),
  KEY `idx_spu_id` (`spu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='SPU规格维度表';

-- ----------------------------
-- Records of t_spu_spec
-- ----------------------------
BEGIN;
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (1, 1, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (2, 2, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (3, 3, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (4, 4, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (5, 5, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (6, 6, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (7, 7, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (8, 8, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (9, 9, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (10, 10, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (11, 11, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (12, 12, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (13, 13, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (14, 14, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (15, 15, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (16, 16, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (17, 17, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (18, 18, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (19, 19, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (20, 20, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (21, 21, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (22, 22, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (23, 23, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (24, 24, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (25, 25, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (26, 26, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (27, 27, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (28, 28, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (29, 29, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (30, 30, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (31, 31, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (32, 32, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (33, 33, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (34, 34, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (35, 35, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (36, 36, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (37, 37, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (38, 38, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (39, 39, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (40, 40, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (41, 41, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (42, 42, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (43, 43, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (44, 44, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (45, 45, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (46, 46, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (47, 47, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (48, 48, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (49, 49, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (50, 50, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (51, 51, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (52, 52, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (53, 53, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (54, 54, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (55, 55, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (56, 56, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (57, 57, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (58, 58, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (59, 59, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (60, 60, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (61, 61, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (62, 62, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (63, 63, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (64, 64, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (65, 65, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (66, 66, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (67, 67, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (68, 68, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (69, 69, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (70, 70, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (71, 71, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (72, 72, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (73, 73, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (74, 74, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (75, 75, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (76, 76, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (77, 77, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (78, 78, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (79, 79, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (80, 80, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (81, 81, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (82, 82, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (83, 83, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (84, 84, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (85, 85, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (86, 86, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (87, 87, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (88, 88, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (89, 89, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (90, 90, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (91, 91, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (92, 92, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (93, 93, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (94, 94, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (95, 95, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (96, 96, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (97, 97, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (98, 98, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (99, 99, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (103, 100, '颜色', '红,黄,蓝');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (104, 100, '尺码', 'S,M,L');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (105, 2001, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (106, 2002, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (107, 2003, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (108, 2004, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (109, 2005, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (110, 2006, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (111, 2007, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (112, 2008, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (113, 2009, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (114, 2010, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (115, 2011, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (116, 2012, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (117, 2013, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (118, 2014, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (119, 2015, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (120, 2016, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (121, 2017, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (122, 2018, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (123, 2019, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (124, 2020, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (125, 2021, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (126, 2022, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (127, 2023, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (128, 2024, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (129, 2025, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (130, 2026, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (131, 2027, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (132, 2028, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (133, 2029, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (134, 2030, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (135, 2031, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (136, 2032, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (137, 2033, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (138, 2034, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (139, 2035, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (140, 2036, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (141, 2037, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (142, 2038, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (143, 2039, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (144, 2040, '颜色', '默认款');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (148, 2041, '颜色', '胡桃木,原木色');
INSERT INTO `t_spu_spec` (`id`, `spu_id`, `spec_name`, `spec_values`) VALUES (149, 2041, '尺寸', '大,中,小');
COMMIT;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(64) NOT NULL COMMENT '用户名',
  `password` varchar(128) NOT NULL COMMENT '密码(BCrypt)',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(256) DEFAULT NULL COMMENT '头像URL',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '1=正常 0=禁用',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='C端用户表';

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` (`id`, `username`, `password`, `nickname`, `phone`, `avatar`, `status`, `create_time`, `update_time`) VALUES (1, 'admin', '$2a$10$ZU0K/L0aaGVE0Emjlk077.z5c21yRjdUiyTfl5Zf2B/xoMw5bZ8US', 'Young', '1231231231', NULL, 1, '2026-07-13 10:39:56', '2026-07-14 11:20:11');
COMMIT;

-- ----------------------------
-- Table structure for t_user_address
-- ----------------------------
DROP TABLE IF EXISTS `t_user_address`;
CREATE TABLE `t_user_address` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `receiver_name` varchar(64) NOT NULL COMMENT '收货人',
  `receiver_phone` varchar(20) NOT NULL COMMENT '收货电话',
  `province` varchar(32) DEFAULT NULL COMMENT '省',
  `city` varchar(32) DEFAULT NULL COMMENT '市',
  `district` varchar(32) DEFAULT NULL COMMENT '区',
  `detail` varchar(256) NOT NULL COMMENT '详细地址',
  `is_default` tinyint NOT NULL DEFAULT '0' COMMENT '1=默认地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='收货地址表';

-- ----------------------------
-- Records of t_user_address
-- ----------------------------
BEGIN;
INSERT INTO `t_user_address` (`id`, `user_id`, `receiver_name`, `receiver_phone`, `province`, `city`, `district`, `detail`, `is_default`, `create_time`) VALUES (2, 1, '1111', '11', '广东省', '广州市', '天河区', '111', 0, '2026-07-14 10:02:55');
INSERT INTO `t_user_address` (`id`, `user_id`, `receiver_name`, `receiver_phone`, `province`, `city`, `district`, `detail`, `is_default`, `create_time`) VALUES (3, 1, '222', '222', '广东省', '珠海市', '香洲区', '222', 0, '2026-07-14 10:02:57');
COMMIT;

-- ----------------------------
-- Table structure for t_user_coupon
-- ----------------------------
DROP TABLE IF EXISTS `t_user_coupon`;
CREATE TABLE `t_user_coupon` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `coupon_id` bigint NOT NULL COMMENT '券模板ID',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0=未使用 1=已使用 2=已过期',
  `receive_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_coupon_id` (`coupon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户优惠券表';

-- ----------------------------
-- Records of t_user_coupon
-- ----------------------------
BEGIN;
INSERT INTO `t_user_coupon` (`id`, `user_id`, `coupon_id`, `status`, `receive_time`, `use_time`) VALUES (1, 1, 1, 1, '2026-07-14 11:03:28', '2026-07-14 11:19:08');
INSERT INTO `t_user_coupon` (`id`, `user_id`, `coupon_id`, `status`, `receive_time`, `use_time`) VALUES (2, 1, 1, 0, '2026-07-14 11:48:47', NULL);
INSERT INTO `t_user_coupon` (`id`, `user_id`, `coupon_id`, `status`, `receive_time`, `use_time`) VALUES (3, 1, 1, 0, '2026-07-14 11:48:49', NULL);
INSERT INTO `t_user_coupon` (`id`, `user_id`, `coupon_id`, `status`, `receive_time`, `use_time`) VALUES (4, 1, 1, 1, '2026-07-16 17:44:37', '2026-07-16 17:45:52');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
