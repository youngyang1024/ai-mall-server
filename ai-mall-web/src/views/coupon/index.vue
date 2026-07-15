<template>
  <div class="coupon-page-inner">
    <div class="page-header" v-if="!isMobile">
      <h1 class="page-title">我的优惠券</h1>
    </div>

    <div class="tabs-wrapper">
      <van-tabs v-model="activeStatus" @change="onTabChange" :line-width="40" color="var(--color-primary)" background="transparent">
        <van-tab title="未使用" :name="0" />
        <van-tab title="已使用" :name="1" />
        <van-tab title="已过期" :name="2" />
      </van-tabs>
    </div>

    <div class="tab-content">
      <div v-if="!myList.length && !loading" class="empty-state">
        <van-icon name="coupon-o" size="48" color="#e8e8e8" />
        <p>暂无相关优惠券</p>
      </div>
      
      <div class="coupon-grid">
        <div 
          v-for="item in myList" 
          :key="item.id" 
          class="coupon-card homary-coupon my-coupon"
          :class="{ 'is-disabled': activeStatus !== 0 }"
        >
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
            <div class="coupon-status">
              <span class="status-text" :class="getStatusClass(activeStatus)">{{ item.statusDesc }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getMyCoupons } from '@/api/coupon'

export default {
  name: 'MyCouponPage',
  data() {
    return {
      activeStatus: 0,
      myList: [],
      loading: false
    }
  },
  created() {
    this.syncStatusFromRoute()
    this.loadMy()
  },
  watch: {
    '$route.query.status'(newVal) {
      this.syncStatusFromRoute()
      this.loadMy()
    }
  },
  methods: {
    syncStatusFromRoute() {
      const status = this.$route.query.status
      if (status !== undefined && status !== null && status !== '') {
        this.activeStatus = Number(status)
      } else {
        this.activeStatus = 0
      }
    },
    onTabChange(name) {
      const query = { ...this.$route.query, status: name }
      this.$router.replace({ path: this.$route.path, query })
    },
    formatTime(item) {
      if (!item.startTime || !item.endTime) return ''
      return `${item.startTime.split(' ')[0]} - ${item.endTime.split(' ')[0]}`
    },
    getStatusClass(status) {
      return {
        'status-unused': status === 0,
        'status-used': status === 1,
        'status-expired': status === 2
      }
    },
    async loadMy() {
      this.loading = true
      try {
        const res = await getMyCoupons({ status: this.activeStatus })
        this.myList = res.data || []
      } finally {
        this.loading = false
      }
    }
  }
}
</script>

<style scoped>
.coupon-page-inner {
  max-width: 1000px;
  margin: 0 auto;
  padding: 40px 16px;
}

.page-header {
  text-align: center;
  margin-bottom: 32px;
}
.page-title {
  font-size: 28px;
  font-weight: 500;
  margin-bottom: 8px;
}

.tabs-wrapper {
  margin-bottom: 24px;
  border-bottom: 1px solid var(--color-border);
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
  width: 120px;
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

.coupon-status {
  margin-top: 12px;
}

.status-text {
  display: inline-block;
  font-size: 14px;
  font-weight: 600;
}

.status-unused {
  color: #c42127;
}

/* Disabled State */
.homary-coupon.is-disabled {
  background: #f5f5f5;
  border-color: #ddd;
}
.homary-coupon.is-disabled .coupon-left {
  border-right-color: #ddd;
}
.homary-coupon.is-disabled .cut-out-top,
.homary-coupon.is-disabled .cut-out-bottom {
  border-color: #ddd;
}
.homary-coupon.is-disabled .amount-wrap {
  color: #999;
}
.homary-coupon.is-disabled .coupon-rule {
  color: #999;
}
.homary-coupon.is-disabled .coupon-right {
  background: #f5f5f5;
}
.homary-coupon.is-disabled:hover {
  transform: none;
  box-shadow: none;
}
.status-used, .status-expired {
  color: #999;
}

@media (max-width: 767px) {
  .coupon-page-inner {
    padding: 16px 0;
  }
  .page-header {
    display: none;
  }
  .coupon-grid {
    grid-template-columns: 1fr;
    padding: 0 16px;
  }
}
</style>
