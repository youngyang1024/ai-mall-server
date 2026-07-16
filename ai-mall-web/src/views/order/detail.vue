<template>
  <div class="order-detail-wrapper">
    <div class="order-detail-page-inner" v-if="order">
      <div class="page-header" v-if="!isMobile">
        <h1 class="page-title">订单详情 #{{ order.orderNo }}</h1>
        <router-link to="/order" class="back-link">&larr; 返回订单列表</router-link>
      </div>

      <div class="detail-layout">
        <!-- 左侧：订单状态、商品、物流信息 -->
        <div class="detail-main">
          <!-- 订单状态卡片 -->
          <div class="detail-card status-card">
            <div class="status-header">
              <h2>订单状态</h2>
              <span class="status-badge" :class="getStatusClass(order.status)">{{ order.statusDesc }}</span>
            </div>
            <div class="status-timeline">
              <div class="timeline-item">
                <div class="timeline-dot active"></div>
                <div class="timeline-content">
                  <p class="title">已下单</p>
                  <p class="time">{{ formatTime(order.createTime) }}</p>
                </div>
              </div>
              <div class="timeline-item" :class="{ disabled: !order.payTime }">
                <div class="timeline-dot" :class="{ active: order.payTime }"></div>
                <div class="timeline-content">
                  <p class="title">已支付</p>
                  <p class="time" v-if="order.payTime">{{ formatTime(order.payTime) }}</p>
                </div>
              </div>
              <div class="timeline-item" :class="{ disabled: !order.shipTime }">
                <div class="timeline-dot" :class="{ active: order.shipTime }"></div>
                <div class="timeline-content">
                  <p class="title">已发货</p>
                  <p class="time" v-if="order.shipTime">{{ formatTime(order.shipTime) }}</p>
                  <p class="desc" v-if="order.logisticsNo">物流单号: {{ order.logisticsNo }}</p>
                </div>
              </div>
              <div class="timeline-item" :class="{ disabled: !order.finishTime }">
                <div class="timeline-dot" :class="{ active: order.finishTime }"></div>
                <div class="timeline-content">
                  <p class="title">已完成</p>
                  <p class="time" v-if="order.finishTime">{{ formatTime(order.finishTime) }}</p>
                </div>
              </div>
            </div>
          </div>

          <!-- 商品信息卡片 -->
          <div class="detail-card">
            <h2 class="card-title">商品清单</h2>
            <div class="order-items">
              <div v-for="item in order.items" :key="item.id" class="order-item">
                <img :src="item.image" :alt="item.spuName" class="item-img" />
                <div class="item-info">
                  <div class="item-name">{{ item.spuName }}</div>
                  <div class="item-spec" v-if="item.skuSpec">{{ formatSpec(item.skuSpec) }}</div>
                  <div class="item-price-qty">
                    <span class="price">¥{{ item.price }}</span>
                    <span class="qty">x {{ item.quantity }}</span>
                  </div>
                  <button
                    v-if="order.status === 3"
                    class="shopify-btn shopify-btn--outline item-review-btn"
                    @click="goReview"
                  >
                    评价
                  </button>
                </div>
                <div class="item-total">
                  ¥{{ (item.price * item.quantity).toFixed(2) }}
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- 右侧：摘要、收货人、操作 -->
        <div class="detail-sidebar">
          <!-- 订单摘要 -->
          <div class="summary-card">
            <h2 class="card-title">订单摘要</h2>
            <div class="summary-details">
              <div class="summary-row">
                <span>商品总额</span>
                <span>¥{{ order.totalAmount }}</span>
              </div>
              <div class="summary-row discount-row" v-if="order.discountAmount > 0">
                <span>优惠抵扣</span>
                <span>-¥{{ order.discountAmount }}</span>
              </div>
              <div class="summary-row">
                <span>运费</span>
                <span>免运费</span>
              </div>
            </div>
            <div class="summary-total">
              <span>实付金额</span>
              <span class="total-price">¥{{ order.payAmount }}</span>
            </div>

            <!-- 操作按钮 -->
            <div class="order-actions">
              <button class="shopify-btn" v-if="order.status === 0" @click="goPay">立即支付</button>
              <button class="shopify-btn shopify-btn--outline" v-if="order.status === 0" @click="handleCancel">取消订单</button>
              
              <button class="shopify-btn" v-if="order.status === 2" @click="handleConfirm">确认收货</button>
              <button class="shopify-btn shopify-btn--outline" v-if="order.status === 1 || order.status === 2" @click="showRefund = true">申请退款</button>
            </div>
          </div>

          <!-- 收货信息 -->
          <div class="info-card">
            <h2 class="card-title">收货信息</h2>
            <div class="info-content">
              <p class="name">{{ receiver.receiverName }}</p>
              <p class="phone">{{ receiver.receiverPhone }}</p>
              <p class="address">{{ receiverText }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 退款弹窗 -->
    <van-dialog v-model="showRefund" title="申请退款" show-cancel-button @confirm="submitRefund" confirm-button-color="var(--color-primary)">
      <div class="refund-form">
        <textarea v-model="refundReason" rows="4" class="custom-textarea" placeholder="请详细填写退款原因..."></textarea>
      </div>
    </van-dialog>
  </div>
</template>

<script>
import { getOrderDetail, cancelOrder, confirmOrder } from '@/api/order'
import { applyRefund } from '@/api/refund'

export default {
  name: 'OrderDetailPage',
  data() {
    return { order: null, showRefund: false, refundReason: '' }
  },
  computed: {
    receiver() {
      if (!this.order || !this.order.receiverInfo) return {}
      try {
        return JSON.parse(this.order.receiverInfo)
      } catch (e) {
        return {}
      }
    },
    receiverText() {
      const r = this.receiver
      return [r.province, r.city, r.district, r.detail].filter(Boolean).join('')
    }
  },
  async created() {
    const res = await getOrderDetail(this.$route.params.orderNo)
    this.order = res.data
  },
  methods: {
    formatSpec(specJsonStr) {
      if (!specJsonStr) return ''
      try {
        const obj = JSON.parse(specJsonStr)
        return Object.entries(obj).map(([k, v]) => `${k}: ${v}`).join(' | ')
      } catch (e) {
        return specJsonStr
      }
    },
    formatTime(timeStr) {
      if (!timeStr) return ''
      return timeStr.replace('T', ' ')
    },
    getStatusClass(status) {
      return {
        'status-unpaid': status === 0,
        'status-shipping': status === 1 || status === 2,
        'status-done': status === 3,
        'status-closed': status === 4
      }
    },
    goPay() {
      this.$router.push({ path: '/order/pay', query: { orderNo: this.order.orderNo } })
    },
    goReview() {
      this.$router.push('/user/review')
    },
    async handleCancel() {
      await this.$dialog.confirm({ title: '确认取消订单？' })
      await cancelOrder(this.order.orderNo)
      this.$toast.success('已取消')
      const res = await getOrderDetail(this.order.orderNo)
      this.order = res.data
    },
    async handleConfirm() {
      await this.$dialog.confirm({ title: '确认已收到货物？' })
      await confirmOrder(this.order.orderNo)
      this.$toast.success('已确认收货')
      const res = await getOrderDetail(this.order.orderNo)
      this.order = res.data
    },
    async submitRefund() {
      if (!this.refundReason.trim()) {
        this.$toast('请填写退款原因')
        return
      }
      await applyRefund({ orderNo: this.order.orderNo, reason: this.refundReason })
      this.$toast.success('退款申请已提交')
      this.refundReason = ''
      const res = await getOrderDetail(this.order.orderNo)
      this.order = res.data
    }
  }
}
</script>

<style scoped>
.order-detail-page-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 16px;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
}
.page-title {
  font-size: 24px;
  font-weight: 500;
  margin: 0;
}
.back-link {
  font-size: 14px;
  color: var(--color-text-muted);
  text-decoration: none;
}
.back-link:hover {
  color: var(--color-primary);
  text-decoration: underline;
}

.detail-layout {
  display: grid;
  grid-template-columns: 1fr 360px;
  gap: 32px;
  align-items: start;
}

.detail-card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 24px;
  margin-bottom: 24px;
}
.card-title {
  font-size: 18px;
  font-weight: 500;
  margin-bottom: 24px;
}

/* Status Timeline */
.status-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
}
.status-header h2 {
  font-size: 18px;
  font-weight: 500;
  margin: 0;
}
.status-badge {
  font-size: 14px;
  font-weight: 600;
}
.status-unpaid { color: #ee0a24; }
.status-shipping { color: #ff976a; }
.status-done { color: #07c160; }
.status-closed { color: var(--color-text-muted); }

.status-timeline {
  display: flex;
  justify-content: space-between;
  position: relative;
  padding-bottom: 16px;
}
.status-timeline::before {
  content: '';
  position: absolute;
  top: 6px;
  left: 10%;
  right: 10%;
  height: 2px;
  background: var(--color-border);
  z-index: 1;
}
.timeline-item {
  position: relative;
  z-index: 2;
  text-align: center;
  flex: 1;
}
.timeline-dot {
  width: 14px;
  height: 14px;
  border-radius: 50%;
  background: var(--color-border);
  margin: 0 auto 12px;
  border: 4px solid #fff;
  box-sizing: content-box;
}
.timeline-dot.active {
  background: var(--color-primary);
}
.timeline-content .title {
  font-size: 13px;
  font-weight: 500;
  margin: 0 0 4px;
}
.timeline-content .time {
  font-size: 12px;
  color: var(--color-text-muted);
  margin: 0;
}
.timeline-content .desc {
  font-size: 12px;
  color: var(--color-text-main);
  margin: 4px 0 0;
}
.timeline-item.disabled .title {
  color: var(--color-text-muted);
}

/* Order Items */
.order-items {
  display: flex;
  flex-direction: column;
  gap: 16px;
}
.order-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--color-surface);
}
.order-item:last-child {
  border-bottom: none;
  padding-bottom: 0;
}
.item-img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: var(--radius-sm);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
}
.item-info {
  flex: 1;
}
.item-name {
  font-weight: 500;
  font-size: 14px;
  margin-bottom: 4px;
}
.item-spec {
  font-size: 12px;
  color: var(--color-text-muted);
  margin-bottom: 8px;
}
.item-price-qty {
  font-size: 13px;
}
.item-price-qty .qty {
  color: var(--color-text-muted);
  margin-left: 8px;
}
.item-review-btn {
  margin-top: 8px;
  padding: 4px 12px;
  font-size: 12px;
  text-transform: none;
  letter-spacing: 0;
}
.item-total {
  font-weight: 600;
  font-size: 16px;
}

/* Sidebar */
.detail-sidebar {
  position: sticky;
  top: 24px;
}
.summary-card {
  background: var(--color-surface);
  padding: 24px;
  border-radius: var(--radius-md);
  margin-bottom: 24px;
}
.summary-details {
  border-bottom: 1px solid var(--color-border);
  padding-bottom: 16px;
  margin-bottom: 16px;
}
.summary-row {
  display: flex;
  justify-content: space-between;
  margin-bottom: 12px;
  color: var(--color-text-muted);
  font-size: 14px;
}
.summary-row:last-child {
  margin-bottom: 0;
}
.discount-row span:last-child {
  color: #ee0a24;
}
.summary-total {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 24px;
}
.total-price {
  font-size: 24px;
}

.order-actions {
  display: flex;
  flex-direction: column;
  gap: 12px;
}
.order-actions .shopify-btn {
  width: 100%;
}

.info-card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 24px;
}
.info-content {
  font-size: 14px;
  line-height: 1.6;
}
.info-content .name {
  font-weight: 600;
}
.info-content .phone {
  color: var(--color-text-main);
  margin-bottom: 8px;
}
.info-content .address {
  color: var(--color-text-muted);
}

.refund-form {
  padding: 16px 24px;
}
.custom-textarea {
  width: 100%;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 12px;
  font-size: 14px;
  outline: none;
  resize: none;
  box-sizing: border-box;
}
.custom-textarea:focus {
  border-color: var(--color-primary);
}

@media (max-width: 767px) {
  .order-detail-page-inner {
    padding: 16px 0;
  }
  .page-header {
    display: none;
  }
  .detail-layout {
    grid-template-columns: 1fr;
    gap: 16px;
  }
  .detail-card, .info-card {
    border-radius: 0;
    border-left: none;
    border-right: none;
    padding: 16px;
  }
  .status-timeline {
    flex-direction: column;
    padding-left: 20px;
    padding-bottom: 0;
  }
  .status-timeline::before {
    top: 0;
    bottom: 0;
    left: 6px;
    width: 2px;
    height: auto;
  }
  .timeline-item {
    text-align: left;
    display: flex;
    align-items: flex-start;
    gap: 16px;
    margin-bottom: 24px;
  }
  .timeline-item:last-child {
    margin-bottom: 0;
  }
  .timeline-dot {
    margin: 0;
    flex-shrink: 0;
    margin-top: 2px;
  }
  .detail-sidebar {
    position: static;
  }
  .summary-card {
    border-radius: 0;
  }
}
</style>
