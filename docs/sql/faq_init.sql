SET NAMES utf8mb4;

TRUNCATE TABLE `t_faq_category`;
TRUNCATE TABLE `t_faq_article`;

INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`) VALUES (1, '推荐主题 (Recommend Topics)', 1, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (1, 1, '优惠券使用指南 (Coupon Guide)', '<p>可以在结账时输入您的优惠券代码。如果优惠券无效，请检查是否过期或是否满足最低消费要求。</p>', 1, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (2, 1, '我可以换货吗？ (Can I Exchange My Order?)', '<p>我们支持30天无理由退换货，请在订单详情页申请换货。</p>', 2, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (3, 1, '如何申请商业账户？ (How to Apply for a Trade Account?)', '<p>请访问我们的商业合作页面并填写申请表，我们的团队将在24小时内联系您。</p>', 3, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (4, 1, '大件商品运送说明 (Shipping Large Item(s))', '<p>大件商品将通过专线物流配送，送货前承运商会与您电话预约时间。</p>', 4, 1);
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`) VALUES (2, '产品常见问题 (Product FAQ)', 2, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (5, 2, '产品是否有保修？ (Does the product have a warranty?)', '<p>是的，我们的大部分产品提供1-3年的有限保修。</p>', 1, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (6, 2, '有实体店可以参观吗？ (Is There a Physical Store or Showroom?)', '<p>目前我们主要在线上运营，以此为您提供最具性价比的商品，暂无实体展厅。</p>', 2, 1);
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`) VALUES (3, '退换货 (Returns & Refunds)', 3, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (7, 3, '30天退货政策 (30 Day Return Policy)', '<p>如果您对购买的商品不满意，可以在收到商品后30天内申请退货。</p>', 1, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (8, 3, '退款需要多长时间？ (How long does refund take?)', '<p>退款通常在收到退回商品后的3-5个工作日内原路退回到您的支付账户。</p>', 2, 1);
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`) VALUES (4, '配送与发货 (Shipping & Delivery)', 4, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (9, 4, '运费怎么计算？ (Shipping FAQs)', '<p>我们为绝大多数订单提供免邮服务，偏远地区可能会收取少量偏远附加费。</p>', 1, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (10, 4, '我可以更改收货地址吗？ (Can I change my address?)', '<p>在订单发货前，您可以联系客服修改收货地址；一旦发货则无法修改。</p>', 2, 1);
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`) VALUES (5, '支付与价格 (Payments & Pricing)', 5, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (11, 5, '支持哪些支付方式？ (Supported Payment Methods)', '<p>我们支持支付宝、微信支付、信用卡及PayPal等多种支付方式。</p>', 1, 1);
INSERT INTO `t_faq_category` (`id`, `name`, `sort`, `status`) VALUES (6, '订单 (Orders)', 6, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (12, 6, '如何修改或取消订单？ (How Do I Change or Cancel My Order?)', '<p>在订单未发货前，您可以随时在"我的订单"页面中取消或修改。</p>', 1, 1);
INSERT INTO `t_faq_article` (`id`, `category_id`, `title`, `content`, `sort`, `status`) VALUES (13, 6, '订单状态术语说明 (Order Status Terms)', '<p>待支付、处理中、已发货、已完成等状态代表了您订单的当前进度。</p>', 2, 1);
