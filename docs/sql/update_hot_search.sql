-- 创建热门搜索表
CREATE TABLE IF NOT EXISTS `t_hot_search` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `keyword` varchar(100) NOT NULL COMMENT '搜索关键词',
  `is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否带有火热图标(0-否 1-是)',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序(越小越靠前)',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态(0-禁用 1-启用)',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='热门搜索词表';

-- 初始化数据
INSERT INTO `t_hot_search` (`keyword`, `is_hot`, `sort`, `status`) VALUES
('布艺沙发', 1, 1, 1),
('实木餐桌', 1, 2, 1),
('极简茶几', 1, 3, 1),
('北欧风吊灯', 0, 4, 1),
('真皮单椅', 0, 5, 1),
('户外折叠椅', 0, 6, 1),
('智能马桶', 0, 7, 1),
('浴室柜', 0, 8, 1);
