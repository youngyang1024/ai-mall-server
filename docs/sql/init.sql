-- AI Mall 数据库初始化脚本
-- 数据库: ai_mall

CREATE DATABASE IF NOT EXISTS ai_mall DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ai_mall;

-- 管理员表
CREATE TABLE IF NOT EXISTS t_admin (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    username    VARCHAR(64)  NOT NULL COMMENT '用户名',
    password    VARCHAR(128) NOT NULL COMMENT '密码(BCrypt)',
    nickname    VARCHAR(64)  DEFAULT NULL COMMENT '昵称',
    status      TINYINT      NOT NULL DEFAULT 1 COMMENT '1=启用 0=禁用',
    create_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

-- C端用户表
CREATE TABLE IF NOT EXISTS t_user (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    username    VARCHAR(64)  NOT NULL COMMENT '用户名',
    password    VARCHAR(128) NOT NULL COMMENT '密码(BCrypt)',
    nickname    VARCHAR(64)  DEFAULT NULL COMMENT '昵称',
    phone       VARCHAR(20)  DEFAULT NULL COMMENT '手机号',
    avatar      VARCHAR(256) DEFAULT NULL COMMENT '头像URL',
    status      TINYINT      NOT NULL DEFAULT 1 COMMENT '1=正常 0=禁用',
    create_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
    update_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='C端用户表';

-- 收货地址表
CREATE TABLE IF NOT EXISTS t_user_address (
    id             BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    user_id        BIGINT       NOT NULL COMMENT '用户ID',
    receiver_name  VARCHAR(64)  NOT NULL COMMENT '收货人',
    receiver_phone VARCHAR(20)  NOT NULL COMMENT '收货电话',
    province       VARCHAR(32)  DEFAULT NULL COMMENT '省',
    city           VARCHAR(32)  DEFAULT NULL COMMENT '市',
    district       VARCHAR(32)  DEFAULT NULL COMMENT '区',
    detail         VARCHAR(256) NOT NULL COMMENT '详细地址',
    is_default     TINYINT      NOT NULL DEFAULT 0 COMMENT '1=默认地址',
    create_time    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    KEY idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='收货地址表';

-- 商品分类表
CREATE TABLE IF NOT EXISTS t_category (
    id          BIGINT      NOT NULL AUTO_INCREMENT COMMENT '主键',
    name        VARCHAR(64) NOT NULL COMMENT '分类名称',
    parent_id   BIGINT      NOT NULL DEFAULT 0 COMMENT '父分类ID，0=顶级',
    sort        INT         NOT NULL DEFAULT 0 COMMENT '排序值',
    status      TINYINT     NOT NULL DEFAULT 1 COMMENT '1=启用 0=禁用',
    create_time DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    KEY idx_parent_id (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品分类表';

-- 商品主体表
CREATE TABLE IF NOT EXISTS t_spu (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    name        VARCHAR(128) NOT NULL COMMENT '商品名称',
    category_id BIGINT       NOT NULL COMMENT '分类ID',
    description TEXT         DEFAULT NULL COMMENT '商品描述',
    main_image  VARCHAR(256) DEFAULT NULL COMMENT '主图URL',
    status      TINYINT      NOT NULL DEFAULT 0 COMMENT '0=下架 1=上架',
    sales_count INT          NOT NULL DEFAULT 0 COMMENT '累计销量',
    create_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    KEY idx_category_id (category_id),
    KEY idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品主体表';

-- 商品规格表
CREATE TABLE IF NOT EXISTS t_sku (
    id        BIGINT        NOT NULL AUTO_INCREMENT COMMENT '主键',
    spu_id    BIGINT        NOT NULL COMMENT '所属SPU',
    spec_json VARCHAR(512)  NOT NULL COMMENT '规格JSON',
    price     DECIMAL(10,2) NOT NULL COMMENT '售价',
    stock     INT           NOT NULL DEFAULT 0 COMMENT '库存',
    image     VARCHAR(256)  DEFAULT NULL COMMENT 'SKU图片',
    sku_code  VARCHAR(64)   DEFAULT NULL COMMENT 'SKU编码',
    PRIMARY KEY (id),
    UNIQUE KEY uk_sku_code (sku_code),
    KEY idx_spu_id (spu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品规格表';

-- SPU规格维度表
CREATE TABLE IF NOT EXISTS t_spu_spec (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    spu_id      BIGINT       NOT NULL COMMENT '所属SPU',
    spec_name   VARCHAR(32)  NOT NULL COMMENT '规格名',
    spec_values VARCHAR(512) NOT NULL COMMENT '可选值，逗号分隔',
    PRIMARY KEY (id),
    KEY idx_spu_id (spu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='SPU规格维度表';

-- 商品图片表
CREATE TABLE IF NOT EXISTS t_spu_image (
    id        BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    spu_id    BIGINT       NOT NULL COMMENT '所属SPU',
    image_url VARCHAR(256) NOT NULL COMMENT '图片URL',
    sort      INT          NOT NULL DEFAULT 0 COMMENT '排序',
    PRIMARY KEY (id),
    KEY idx_spu_id (spu_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品图片表';

-- 购物车表
CREATE TABLE IF NOT EXISTS t_cart (
    id          BIGINT   NOT NULL AUTO_INCREMENT COMMENT '主键',
    user_id     BIGINT   NOT NULL COMMENT '用户ID',
    sku_id      BIGINT   NOT NULL COMMENT 'SKU ID',
    quantity    INT      NOT NULL DEFAULT 1 COMMENT '数量',
    checked     TINYINT  NOT NULL DEFAULT 1 COMMENT '1=选中 0=未选中',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '加入时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_user_sku (user_id, sku_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='购物车表';

-- 订单表
CREATE TABLE IF NOT EXISTS t_order (
    id              BIGINT        NOT NULL AUTO_INCREMENT COMMENT '主键',
    order_no        VARCHAR(32)   NOT NULL COMMENT '订单编号',
    user_id         BIGINT        NOT NULL COMMENT '用户ID',
    total_amount    DECIMAL(10,2) NOT NULL COMMENT '商品总额',
    discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '优惠金额',
    pay_amount      DECIMAL(10,2) NOT NULL COMMENT '实付金额',
    coupon_id       BIGINT        DEFAULT NULL COMMENT '使用的用户券ID',
    status          TINYINT       NOT NULL COMMENT '订单状态',
    receiver_info   VARCHAR(512)  NOT NULL COMMENT '收货信息JSON快照',
    remark          VARCHAR(256)  DEFAULT NULL COMMENT '买家备注',
    logistics_no    VARCHAR(64)   DEFAULT NULL COMMENT '物流单号',
    pay_time        DATETIME      DEFAULT NULL COMMENT '支付时间',
    ship_time       DATETIME      DEFAULT NULL COMMENT '发货时间',
    finish_time     DATETIME      DEFAULT NULL COMMENT '完成时间',
    create_time     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
    update_time     DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_order_no (order_no),
    KEY idx_user_id (user_id),
    KEY idx_status (status),
    KEY idx_create_time (create_time)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 订单明细表
CREATE TABLE IF NOT EXISTS t_order_item (
    id       BIGINT        NOT NULL AUTO_INCREMENT COMMENT '主键',
    order_id BIGINT        NOT NULL COMMENT '订单ID',
    spu_id   BIGINT        NOT NULL COMMENT 'SPU ID',
    sku_id   BIGINT        NOT NULL COMMENT 'SKU ID',
    spu_name VARCHAR(128)  DEFAULT NULL COMMENT '商品名称快照',
    sku_spec VARCHAR(256)  DEFAULT NULL COMMENT '规格快照',
    image    VARCHAR(256)  DEFAULT NULL COMMENT '商品图片快照',
    price    DECIMAL(10,2) NOT NULL COMMENT '成交单价',
    quantity INT           NOT NULL COMMENT '购买数量',
    PRIMARY KEY (id),
    KEY idx_order_id (order_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单明细表';

-- 轮播图表
CREATE TABLE IF NOT EXISTS t_banner (
    id          BIGINT       NOT NULL AUTO_INCREMENT COMMENT '主键',
    title       VARCHAR(128) DEFAULT NULL COMMENT '标题',
    image_url   VARCHAR(256) NOT NULL COMMENT '图片URL',
    link_url    VARCHAR(256) DEFAULT NULL COMMENT '跳转链接',
    sort        INT          NOT NULL DEFAULT 0 COMMENT '排序',
    status      TINYINT      NOT NULL DEFAULT 1 COMMENT '1=启用 0=禁用',
    create_time DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='轮播图表';

-- 优惠券模板表
CREATE TABLE IF NOT EXISTS t_coupon (
    id             BIGINT        NOT NULL AUTO_INCREMENT COMMENT '主键',
    name           VARCHAR(128)  NOT NULL COMMENT '券名称',
    type           TINYINT       NOT NULL DEFAULT 1 COMMENT '1=满减券',
    threshold      DECIMAL(10,2) NOT NULL COMMENT '满减门槛',
    discount       DECIMAL(10,2) NOT NULL COMMENT '减免金额',
    total_count    INT           NOT NULL COMMENT '发放总量',
    received_count INT           NOT NULL DEFAULT 0 COMMENT '已领取数',
    start_time     DATETIME      NOT NULL COMMENT '有效期开始',
    end_time       DATETIME      NOT NULL COMMENT '有效期结束',
    status         TINYINT       NOT NULL DEFAULT 1 COMMENT '1=启用 0=停用',
    create_time    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券模板表';

-- 用户优惠券表
CREATE TABLE IF NOT EXISTS t_user_coupon (
    id           BIGINT   NOT NULL AUTO_INCREMENT COMMENT '主键',
    user_id      BIGINT   NOT NULL COMMENT '用户ID',
    coupon_id    BIGINT   NOT NULL COMMENT '券模板ID',
    status       TINYINT  NOT NULL DEFAULT 0 COMMENT '0=未使用 1=已使用 2=已过期',
    receive_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '领取时间',
    use_time     DATETIME DEFAULT NULL COMMENT '使用时间',
    PRIMARY KEY (id),
    KEY idx_user_id (user_id),
    KEY idx_coupon_id (coupon_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户优惠券表';

-- 退款申请表
CREATE TABLE IF NOT EXISTS t_refund (
    id            BIGINT        NOT NULL AUTO_INCREMENT COMMENT '主键',
    refund_no     VARCHAR(32)   NOT NULL COMMENT '退款单号',
    order_id      BIGINT        NOT NULL COMMENT '关联订单',
    user_id       BIGINT        NOT NULL COMMENT '申请用户',
    refund_amount DECIMAL(10,2) NOT NULL COMMENT '退款金额',
    reason        VARCHAR(256)  NOT NULL COMMENT '退款原因',
    status        TINYINT       NOT NULL DEFAULT 0 COMMENT '0=待审核 1=已通过 2=已拒绝',
    order_status_before TINYINT NOT NULL COMMENT '申请前订单状态',
    reject_reason VARCHAR(256)  DEFAULT NULL COMMENT '拒绝原因',
    create_time   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '申请时间',
    update_time   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_refund_no (refund_no),
    KEY idx_order_id (order_id),
    KEY idx_user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='退款申请表';

-- 预置管理员账号 admin / admin123
INSERT INTO t_admin (username, password, nickname, status)
VALUES ('admin', '$2b$10$GyBqcawgTI2YewgRzNYGJOoRiqlSSdOS1bxRCICiTU6xzHgpBctMa', '超级管理员', 1)
ON DUPLICATE KEY UPDATE username = username;

-- 演示数据（分类、100 个商品、轮播图）请执行：
-- mysql -u root -p ai_mall < docs/sql/seed_data.sql
