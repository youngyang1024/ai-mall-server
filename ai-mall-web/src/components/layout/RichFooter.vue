<template>
  <footer class="rich-footer">
    <div class="footer-inner">
      <div class="footer-columns">
        <div class="footer-col">
          <h4 class="footer-title">关于 AI Mall</h4>
          <p class="footer-desc">
            我们致力于为您提供高品质、设计感十足的家居产品。从客厅到卧室，让每一个空间都充满灵感与温馨。
          </p>
        </div>
        <div class="footer-col">
          <h4 class="footer-title">快速链接</h4>
          <ul class="footer-links">
            <li><router-link to="/">首页</router-link></li>
            <li><router-link to="/category">全部分类</router-link></li>
            <li><router-link to="/product">最新商品</router-link></li>
            <li><router-link to="/coupon">领券中心</router-link></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4 class="footer-title">客户服务</h4>
          <ul class="footer-links">
            <li><router-link to="/service-center">服务中心</router-link></li>
            <li><router-link to="/help">帮助中心</router-link></li>
            <li><router-link to="/user">我的账户</router-link></li>
            <li><router-link to="/order">订单查询</router-link></li>
            <li><router-link to="/refund">退换货政策</router-link></li>
          </ul>
        </div>
        <div class="footer-col">
          <h4 class="footer-title">订阅我们的简报</h4>
          <p class="footer-desc">获取最新产品资讯与专属优惠。</p>
          <div class="newsletter-form">
            <input type="email" placeholder="您的邮箱地址" />
            <button type="button">→</button>
          </div>
        </div>
      </div>
      <div class="footer-bottom">
        <div class="copyright">
          © {{ new Date().getFullYear() }} AI Mall. All rights reserved.
        </div>
        <div class="payment-icons">
          <i class="iconfont icon-alipay"></i>
          <i class="iconfont icon-wechat-pay"></i>
          <i class="iconfont icon-visa"></i>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'RichFooter'
}
</script>

<style scoped>
.rich-footer {
  background-color: var(--color-surface);
  border-top: 1px solid var(--color-border);
  padding: 60px 24px 24px;
  color: var(--color-text-main);
}
.footer-inner {
  max-width: 1200px;
  margin: 0 auto;
}
.footer-columns {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 40px;
  margin-bottom: 60px;
}
.footer-title {
  font-size: 14px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 20px;
}
.footer-desc {
  font-size: 13px;
  color: var(--color-text-muted);
  line-height: 1.6;
}
.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}
.footer-links li {
  margin-bottom: 12px;
}
.footer-links a {
  font-size: 13px;
  color: var(--color-text-muted);
  transition: color 0.2s;
}
.footer-links a:hover {
  color: var(--color-primary);
}
.newsletter-form {
  display: flex;
  margin-top: 16px;
  border: 1px solid var(--color-border);
  border-radius: 2px;
  overflow: hidden;
}
.newsletter-form input {
  flex: 1;
  border: none;
  padding: 10px 12px;
  font-size: 13px;
  outline: none;
  background: #fff;
}
.newsletter-form button {
  border: none;
  background: var(--color-primary);
  color: #fff;
  padding: 0 16px;
  cursor: pointer;
}
.footer-bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 24px;
  border-top: 1px solid var(--color-border);
  font-size: 12px;
  color: var(--color-text-muted);
}

@media (max-width: 767px) {
  .footer-columns {
    grid-template-columns: 1fr;
    gap: 32px;
  }
  .footer-bottom {
    flex-direction: column;
    gap: 16px;
    text-align: center;
  }
}
</style>
