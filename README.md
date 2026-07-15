# AI Mall 独立站商城

以学习为目的的独立站商城练手项目（V1 基础全流程）。

## 工程结构

```
ai-mall-server/
├── ai-mall-common/        # 公共模块（实体、工具、统一响应）
├── ai-mall-toB-server/    # B端管理 API（:8081）
├── ai-mall-toC-server/    # C端商城 API（:9091）
├── ai-mall-admin/         # B端管理前端（:8082）
├── ai-mall-web/           # C端商城前端（:9092）
└── docs/                  # 文档与 SQL 脚本
```

## 环境要求

| 工具 | 版本 |
|------|------|
| JDK | 11 |
| Maven | 3.6+ |
| Node.js | 16+ |
| MySQL | 8.0+ |
| Redis | 6.0+ |
| MinIO | latest |

## 配置项说明

| 配置 | 文件 | 说明 |
|------|------|------|
| 数据库连接 | `*/application-dev.yml` | 默认 `root/root@127.0.0.1:3306/ai_mall` |
| Redis | `*/application-dev.yml` | 默认 `127.0.0.1:6379` |
| JWT 密钥/有效期 | `application.yml` | 默认 7 天（604800000ms） |
| 订单支付超时 | toC `application.yml` | `order.pay-timeout-minutes: 30` |
| 超时兜底扫描 | toC `application.yml` | `order.timeout-scan-cron: 0 */5 * * * ?` |
| MinIO | toB `application.yml` | endpoint、accessKey、bucket 等 |

## 中间件启动

### MySQL

```bash
mysql -u root -p < docs/sql/init.sql
mysql -u root -p ai_mall < docs/sql/seed_data.sql
```

`seed_data.sql` 包含：
- **27 个分类**（6 个一级 + 21 个二级，结构参考 [Homary](https://www.homary.com/)）
- **100 个上架商品**（名称已翻译为中文，图片 URL 直接复用 Homary CDN）
- **3 张首页轮播图**

如需重新生成演示数据（会覆盖分类/商品/轮播）：

```bash
python3 scripts/generate_seed_sql.py
mysql -u root -p ai_mall < docs/sql/seed_data.sql
```

默认连接：`127.0.0.1:3306/ai_mall`，用户名/密码 `root/root`（可在 `application-dev.yml` 修改）。

> 若数据库已初始化，退款表需包含 `order_status_before` 字段，可执行：
> `ALTER TABLE t_refund ADD COLUMN order_status_before TINYINT NOT NULL DEFAULT 1 COMMENT '申请前订单状态' AFTER status;`

### Redis

```bash
redis-server --notify-keyspace-events Ex
```

订单超时取消依赖 Key 过期事件，同时有每 5 分钟定时任务兜底。

### MinIO

```bash
minio server /data --console-address ":9001"
```

创建 bucket `ai-mall` 并配置公开读策略。连接信息见 `ai-mall-toB-server/src/main/resources/application.yml`。

## 后端启动

```bash
mvn clean install -DskipTests

cd ai-mall-toB-server && mvn spring-boot:run
cd ai-mall-toC-server && mvn spring-boot:run
```

## 前端启动

```bash
cd ai-mall-admin && npm install && npm run serve
cd ai-mall-web && npm install && npm run serve
```

## 访问地址

| 服务 | 地址 |
|------|------|
| B端 API 文档 | http://localhost:8081/doc.html |
| C端 API 文档 | http://localhost:9091/doc.html |
| B端管理后台 | http://localhost:8082 |
| C端商城 | http://localhost:9092 |

## 默认账号

| 端 | 用户名 | 密码 |
|----|--------|------|
| B端管理员 | admin | admin123 |
| C端用户 | 自行注册 | — |

## 联调验证清单

### 10.1 端到端主流程

1. C端注册/登录 → 浏览商品 → 加购 → 结算下单
2. 模拟支付 → B端发货 → C端确认收货
3. B端看板查看今日指标与图表

### 10.2 订单超时取消

1. 创建订单不支付，等待 30 分钟；或临时将 `order.pay-timeout-minutes` 改为 1 测试
2. 确认订单自动取消且库存回滚
3. 可观察 Redis Key `order:timeout:{orderNo}` 过期

### 10.3 优惠券

1. B端创建优惠券 → C端领取
2. 结算页选券抵扣 → 支付后券变为已使用
3. 过期券或未满门槛券应被拒绝

### 10.4 退款

1. 已支付/已发货订单申请退款
2. B端审核通过 → 订单变已退款、库存回滚
3. B端审核拒绝 → 订单恢复原状态

## 技术栈

- **后端**：Java 11、Spring Boot 2.6、MyBatis、PageHelper、Redis、Knife4j、MinIO（S3 API）
- **B端前端**：Vue 2.6、Element UI、ECharts
- **C端前端**：Vue 2.6、Vant 2.x

详细设计见 [docs/V1-技术方案.md](docs/V1-技术方案.md)。
