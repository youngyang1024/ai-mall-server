USE ai_mall;

CREATE TABLE IF NOT EXISTS t_service_category (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
    code VARCHAR(64) NOT NULL COMMENT '分类编码',
    name VARCHAR(64) NOT NULL COMMENT '分类名称',
    icon VARCHAR(64) DEFAULT NULL COMMENT '图标名',
    need_order_no TINYINT NOT NULL DEFAULT 0 COMMENT '是否需要订单号 0否 1是',
    sort INT NOT NULL DEFAULT 0 COMMENT '排序',
    status TINYINT NOT NULL DEFAULT 1 COMMENT '状态 0禁用 1启用',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_service_category_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务中心问题大类表';

CREATE TABLE IF NOT EXISTS t_service_issue (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
    category_id BIGINT NOT NULL COMMENT '服务大类ID',
    code VARCHAR(64) NOT NULL COMMENT '问题编码',
    name VARCHAR(128) NOT NULL COMMENT '问题名称',
    sort INT NOT NULL DEFAULT 0 COMMENT '排序',
    status TINYINT NOT NULL DEFAULT 1 COMMENT '状态 0禁用 1启用',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_service_issue_code (code),
    KEY idx_service_issue_category_id (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务中心问题小类表';

CREATE TABLE IF NOT EXISTS t_service_ticket (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
    ticket_no VARCHAR(32) NOT NULL COMMENT '工单编号',
    user_id BIGINT NOT NULL COMMENT '用户ID',
    category_id BIGINT NOT NULL COMMENT '大类ID',
    category_name VARCHAR(64) NOT NULL COMMENT '大类名称',
    issue_id BIGINT NOT NULL COMMENT '小类ID',
    issue_name VARCHAR(128) NOT NULL COMMENT '小类名称',
    order_no VARCHAR(32) DEFAULT NULL COMMENT '订单号',
    content TEXT NOT NULL COMMENT '工单首条描述',
    status TINYINT NOT NULL DEFAULT 0 COMMENT '状态 0待处理 1处理中 2已完成',
    contact_first_name VARCHAR(64) NOT NULL COMMENT '联系人名',
    contact_last_name VARCHAR(64) NOT NULL COMMENT '联系人姓',
    contact_email VARCHAR(128) NOT NULL COMMENT '联系人邮箱',
    contact_area_code VARCHAR(16) DEFAULT NULL COMMENT '电话区号',
    contact_phone VARCHAR(32) NOT NULL COMMENT '联系电话',
    last_reply_user_type TINYINT NOT NULL DEFAULT 1 COMMENT '最后回复人类型 1用户 2管理员',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (id),
    UNIQUE KEY uk_service_ticket_no (ticket_no),
    KEY idx_service_ticket_user_id (user_id),
    KEY idx_service_ticket_status (status),
    KEY idx_service_ticket_order_no (order_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务工单主表';

CREATE TABLE IF NOT EXISTS t_service_ticket_reply (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
    ticket_id BIGINT NOT NULL COMMENT '工单ID',
    user_type TINYINT NOT NULL COMMENT '回复人类型 1用户 2管理员',
    user_id BIGINT NOT NULL COMMENT '回复人ID',
    content TEXT NOT NULL COMMENT '回复内容',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    KEY idx_service_ticket_reply_ticket_id (ticket_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务工单回复表';

CREATE TABLE IF NOT EXISTS t_service_ticket_attachment (
    id BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键',
    ticket_id BIGINT NOT NULL COMMENT '工单ID',
    reply_id BIGINT NOT NULL COMMENT '回复ID',
    user_type TINYINT NOT NULL COMMENT '上传人类型 1用户 2管理员',
    file_name VARCHAR(128) NOT NULL COMMENT '文件名',
    file_url VARCHAR(512) NOT NULL COMMENT '文件地址',
    file_type VARCHAR(32) NOT NULL COMMENT '文件类型',
    file_size BIGINT NOT NULL DEFAULT 0 COMMENT '文件大小字节',
    create_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    PRIMARY KEY (id),
    KEY idx_service_ticket_attachment_ticket_id (ticket_id),
    KEY idx_service_ticket_attachment_reply_id (reply_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='服务工单附件表';

DELETE FROM t_service_issue;
DELETE FROM t_service_category;

INSERT INTO t_service_category (id, code, name, icon, need_order_no, sort, status) VALUES
(1, 'RETURN_REFUND', '退货与退款', 'revoke', 1, 1, 1),
(2, 'SHIPPING_DELIVERY', '运输与交付', 'logistics', 1, 2, 1),
(3, 'PRODUCT_SUPPORT', '产品支持', 'setting-o', 1, 3, 1),
(4, 'ACCOUNT_PAYMENT', '账户与支付', 'balance-pay', 1, 4, 1),
(5, 'SUGGESTION_FEEDBACK', '建议与反馈', 'chat-o', 0, 5, 1);

INSERT INTO t_service_issue (category_id, code, name, sort, status) VALUES
(1, 'RETURN_DONT_WANT', '只是/不喜欢它/无法接受它', 1, 1),
(1, 'RETURN_NOT_DESCRIBED', '并不像所描述的那样', 2, 1),
(1, 'RETURN_NOT_WORKING', '无法使用/出现故障', 3, 1),
(1, 'RETURN_DAMAGED', '送达时损坏了', 4, 1),
(1, 'RETURN_NOT_INTENDED', '并未达到预期效果', 5, 1),
(1, 'RETURN_WRONG_ITEM', '送错了商品', 6, 1),

(2, 'SHIP_TRACKING_NEEDED', '需要跟踪信息', 1, 1),
(2, 'SHIP_TRACKING_INVALID', '跟踪信息无效', 2, 1),
(2, 'SHIP_TRACKING_NOT_UPDATED', '跟踪信息未更新', 3, 1),
(2, 'SHIP_PACKAGE_DAMAGED', '包裹在运输过程中受到损坏', 4, 1),
(2, 'SHIP_CUSTOMS', '海关清关', 5, 1),
(2, 'SHIP_DELIVERED_NOT_RECEIVED', '显示已交付，但并未收到货物', 6, 1),

(3, 'SUPPORT_INSTALLATION', '产品安装指导', 1, 1),
(3, 'SUPPORT_USAGE', '产品使用咨询', 2, 1),
(3, 'SUPPORT_PARTS', '零部件补发', 3, 1),
(3, 'SUPPORT_MANUAL', '说明书/视频资料', 4, 1),
(3, 'SUPPORT_WARRANTY', '保修与维护', 5, 1),
(3, 'SUPPORT_TROUBLESHOOT', '功能故障排查', 6, 1),

(4, 'ACCOUNT_REGISTER', '注册', 1, 1),
(4, 'ACCOUNT_PASSWORD', '更改登录密码', 2, 1),
(4, 'ACCOUNT_ORDER_CANCEL', '订单/取消订单', 3, 1),
(4, 'ACCOUNT_INFO', '高级账户信息', 4, 1),
(4, 'ACCOUNT_PAY_FAILED', '无法进行支付', 5, 1),
(4, 'ACCOUNT_PAY_STATUS', '确认支付状态', 6, 1),

(5, 'FEEDBACK_SHIPPING', '运输改进', 1, 1),
(5, 'FEEDBACK_PRODUCT', '产品反馈', 2, 1),
(5, 'FEEDBACK_WEBSITE', '网站出现故障', 3, 1),
(5, 'FEEDBACK_SERVICE', '客户服务', 4, 1);
