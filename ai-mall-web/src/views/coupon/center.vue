<template>
  <page-shell title="领券中心" :show-back="isMobile">
    <div class="coupon-page-inner">
      <div class="page-header">
        <h1 class="page-title">领券中心</h1>
        <p class="page-desc">领取专属优惠，享受更多折扣</p>
      </div>

      <div class="tab-content">
        <div v-if="!availableList.length" class="empty-state">
          <van-icon name="coupon-o" size="48" color="#e8e8e8" />
          <p>暂无可领优惠券</p>
        </div>
        <div class="coupon-grid">
          <div v-for="item in availableList" :key="item.id" class="coupon-card homary-coupon">
          <div class="coupon-left">
            <div class="amount-wrap">
              <span class="currency">¥</span>
              <span class="value">{{ item.discount }}</span>
              <span class="unit">立减</span>
            </div>
            <p class="coupon-rule">满 ¥{{ item.threshold }} 可用</p>
            <div class="cut-out-top"></div>
            <div class="cut-out-bottom"></div>
          </div>
            <div class="coupon-right">
              <p class="coupon-time">{{ formatTime(item) }}</p>
            <div class="coupon-action">
              <button 
                class="receive-btn" 
                @click="handleReceive(item)"
              >
                立即领取
              </button>
              <p class="coupon-remain">剩余 {{ item.remainCount }} 张</p>
            </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </page-shell>
</template>

<script>
import { getAvailableCoupons, receiveCoupon } from '@/api/coupon'

export default {
  name: 'CouponCenterPage',
  data() {
    return {
      availableList: []
    }
  },
  async created() {
    await this.loadAvailable()
  },
  methods: {
    formatTime(item) {
      if (!item.startTime || !item.endTime) return ''
      return `${item.startTime.split(' ')[0]} - ${item.endTime.split(' ')[0]}`
    },
    async loadAvailable() {
      const res = await getAvailableCoupons()
      this.availableList = res.data || []
    },
    async handleReceive(item) {
      if (!this.$store.getters.isLogin) {
        this.$router.push({ path: '/login', query: { redirect: '/coupon-center' } })
        return
      }
      await receiveCoupon(item.id)
      this.$toast.success('领取成功')
      await this.loadAvailable()
    }
  }
}
</script>

<style scoped>
.coupon-page-inner {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 16px;
}

.page-header {
  text-align: center;
  margin-bottom: 40px;
}
.page-title {
  font-size: 28px;
  font-weight: 500;
  margin-bottom: 8px;
}
.page-desc {
  color: var(--color-text-muted);
  font-size: 14px;
}

.empty-state {
  text-align: center;
  padding: 80px 0;
  color: var(--color-text-muted);
}
.empty-state p {
  margin-top: 16px;
  font-size: 14px;
}

.coupon-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
  gap: 20px;
}

/* Homary Style Coupon */
.homary-coupon {
  position: relative;
  display: flex;
  background: #fffcf8;
  border: 1px solid #e1b490;
  border-radius: 8px;
  overflow: hidden;
  transition: transform 0.2s, box-shadow 0.2s;
}

.homary-coupon:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(225, 180, 144, 0.2);
}

.coupon-left {
  position: relative;
  flex: 1;
  padding: 24px 20px;
  border-right: 1px dashed #e1b490;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

/* The semi-circle cutouts on the dashed line */
.cut-out-top,
.cut-out-bottom {
  position: absolute;
  right: -8px;
  width: 16px;
  height: 16px;
  background-color: var(--color-surface); /* Matches the background of the page */
  border-radius: 50%;
  border: 1px solid #e1b490;
  z-index: 2;
}

.cut-out-top {
  top: -9px;
  border-bottom-color: transparent;
  border-left-color: transparent;
  transform: rotate(45deg);
}

.cut-out-bottom {
  bottom: -9px;
  border-top-color: transparent;
  border-right-color: transparent;
  transform: rotate(45deg);
}

.amount-wrap {
  display: flex;
  align-items: baseline;
  color: #c42127; /* Homary Red */
  margin-bottom: 8px;
}

.amount-wrap .currency {
  font-size: 20px;
  font-weight: 600;
  margin-right: 4px;
}

.amount-wrap .value {
  font-size: 32px;
  font-weight: 700;
  letter-spacing: -1px;
}

.amount-wrap .unit {
  font-size: 18px;
  font-weight: 600;
  margin-left: 8px;
}

.coupon-rule {
  font-size: 14px;
  color: #666;
  margin: 0;
}

.coupon-right {
  width: 140px;
  padding: 24px 16px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;
  background: #fffcf8;
}

.coupon-time {
  font-size: 12px;
  color: #999;
  text-align: center;
  line-height: 1.4;
  margin: 0;
}

.coupon-action {
  margin-top: 12px;
  text-align: center;
}

.receive-btn {
  background: #222;
  color: #fff;
  border: none;
  padding: 8px 16px;
  font-size: 12px;
  font-weight: 600;
  border-radius: 2px;
  cursor: pointer;
  white-space: nowrap;
  transition: opacity 0.2s;
}

.receive-btn:hover {
  opacity: 0.8;
}

/* Not needed anymore
.receive-btn.received {
  background: transparent;
  color: #999;
  border: 1px solid #ddd;
  cursor: not-allowed;
}

.receive-btn.received:hover {
  opacity: 1;
}
*/

.coupon-remain {
  font-size: 11px;
  color: #999;
  margin: 8px 0 0;
}

@media (max-width: 767px) {
  .coupon-page-inner {
    padding: 24px 16px;
  }
  .coupon-grid {
    grid-template-columns: 1fr;
  }
}
</style>