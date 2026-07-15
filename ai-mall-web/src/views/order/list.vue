<template>
  <div class="order-page-inner">
      <h1 class="page-title" v-if="!isMobile">我的订单</h1>

      <div class="tabs-wrapper">
        <van-tabs v-model="activeStatus" @change="onTabChange" :line-width="40" color="var(--color-primary)" background="transparent">
          <van-tab title="全部订单" name="" />
          <van-tab title="待支付" :name="0" />
          <van-tab title="待发货" :name="1" />
          <van-tab title="已发货" :name="2" />
          <van-tab title="已完成" :name="3" />
        </van-tabs>
      </div>

      <div class="order-list">
        <div v-if="!list.length && !loading" class="empty-state">
          <van-icon name="orders-o" size="48" color="#e8e8e8" />
          <p>暂无相关订单</p>
        </div>

        <div v-for="order in list" :key="order.orderNo" class="order-card" @click="goDetail(order.orderNo)">
          <div class="order-header">
            <div class="header-left">
              <span class="order-no">订单号: {{ order.orderNo }}</span>
              <span class="order-time">{{ formatTime(order.createTime) }}</span>
            </div>
            <div class="header-right">
              <span class="order-status" :class="getStatusClass(order.status)">{{ order.statusDesc }}</span>
            </div>
          </div>

          <div class="order-body">
            <div class="order-items">
              <div v-for="item in (order.items || []).slice(0, 3)" :key="item.id" class="item-preview">
                <img :src="item.image" :alt="item.spuName" class="item-img" />
              </div>
              <div v-if="(order.items || []).length > 3" class="item-more">
                共 {{ order.items.length }} 件
              </div>
            </div>
            
            <div class="order-summary">
              <div class="pay-amount">
                <span class="label">实付：</span>
                <span class="value">¥{{ order.payAmount }}</span>
              </div>
            </div>
          </div>

          <div class="order-footer" v-if="order.status === 0" @click.stop>
            <button class="shopify-btn" @click="goPay(order.orderNo)">立即支付</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getOrderList } from '@/api/order'

export default {
  name: 'OrderListPage',
  data() {
    return {
      activeStatus: '',
      list: [],
      loading: false
    }
  },
  created() {
    this.syncStatusFromRoute()
    this.loadData()
  },
  watch: {
    '$route.query.status'(newVal) {
      this.syncStatusFromRoute()
      this.loadData()
    }
  },
  methods: {
    syncStatusFromRoute() {
      const status = this.$route.query.status
      if (status !== undefined && status !== null && status !== '') {
        this.activeStatus = Number(status)
      } else {
        this.activeStatus = ''
      }
    },
    onTabChange(name) {
      // 当点击 Tab 时，同步更新 URL
      const query = { ...this.$route.query }
      if (name === '') {
        delete query.status
      } else {
        query.status = name
      }
      this.$router.replace({ path: this.$route.path, query })
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
    async loadData() {
      this.loading = true
      try {
        const params = { pageNum: 1, pageSize: 50 }
        if (this.activeStatus !== '') params.status = this.activeStatus
        const res = await getOrderList(params)
        this.list = res.data.list || []
      } finally {
        this.loading = false
      }
    },
    goDetail(orderNo) {
      this.$router.push('/order/' + orderNo)
    },
    goPay(orderNo) {
      this.$router.push({ path: '/order/pay', query: { orderNo } })
    }
  }
}
</script>

<style scoped>
.order-page-inner {
  max-width: 1000px;
  margin: 0 auto;
  padding: 40px 16px;
}

.page-title {
  font-size: 28px;
  font-weight: 500;
  margin-bottom: 32px;
  text-align: center;
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

.order-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.order-card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 20px;
  cursor: pointer;
  transition: box-shadow 0.2s;
}
.order-card:hover {
  box-shadow: var(--shadow-sm);
}

.order-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--color-surface);
  margin-bottom: 16px;
}
.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}
.order-no {
  font-weight: 600;
  font-size: 14px;
}
.order-time {
  font-size: 12px;
  color: var(--color-text-muted);
}
.order-status {
  font-size: 14px;
  font-weight: 600;
}
.status-unpaid { color: #ee0a24; }
.status-shipping { color: #ff976a; }
.status-done { color: #07c160; }
.status-closed { color: var(--color-text-muted); }

.order-body {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.order-items {
  display: flex;
  align-items: center;
  gap: 12px;
}
.item-preview {
  width: 64px;
  height: 64px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  overflow: hidden;
  background: var(--color-surface);
}
.item-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.item-more {
  font-size: 13px;
  color: var(--color-text-muted);
}

.order-summary {
  text-align: right;
}
.pay-amount .label {
  font-size: 13px;
  color: var(--color-text-muted);
}
.pay-amount .value {
  font-size: 18px;
  font-weight: 600;
  color: var(--color-text-main);
}

.order-footer {
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid var(--color-surface);
  display: flex;
  justify-content: flex-end;
}
.order-footer .shopify-btn {
  padding: 8px 24px;
  font-size: 13px;
}

@media (max-width: 767px) {
  .order-page-inner {
    padding: 16px 0;
  }
  .page-title {
    display: none;
  }
  .order-card {
    border-radius: 0;
    border-left: none;
    border-right: none;
  }
  .header-left {
    flex-direction: column;
    align-items: flex-start;
    gap: 4px;
  }
}
</style>
