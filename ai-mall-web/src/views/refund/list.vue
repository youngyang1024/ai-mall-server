<template>
  <div class="refund-page-inner">
    <h1 class="page-title" v-if="!isMobile">售后中心</h1>
      
      <div class="refund-list">
        <div v-if="!list.length && !loading" class="empty-state">
          <van-icon name="balance-list-o" size="48" color="#e8e8e8" />
          <p>暂无售后记录</p>
        </div>

        <div v-for="item in list" :key="item.id" class="refund-card" @click="$router.push('/refund/' + item.id)">
          <div class="refund-header">
            <div class="header-left">
              <span class="refund-no">售后编号: {{ item.refundNo }}</span>
              <span class="refund-time">{{ formatTime(item.createTime) }}</span>
            </div>
            <div class="header-right">
              <span class="refund-status" :class="getStatusClass(item.status)">{{ item.statusDesc }}</span>
            </div>
          </div>
          <div class="refund-body">
            <div class="info-row">
              <span class="label">关订单号</span>
              <span class="value">{{ item.orderNo }}</span>
            </div>
            <div class="info-row">
              <span class="label">退款金额</span>
              <span class="value price">¥{{ item.refundAmount }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getRefundList } from '@/api/refund'

export default {
  name: 'RefundListPage',
  data() {
    return { list: [], loading: false }
  },
  async created() {
    this.loading = true
    try {
      const res = await getRefundList({ pageNum: 1, pageSize: 50 })
      this.list = res.data.list || []
    } finally {
      this.loading = false
    }
  },
  methods: {
    formatTime(timeStr) {
      if (!timeStr) return ''
      return timeStr.replace('T', ' ')
    },
    getStatusClass(status) {
      return {
        'status-pending': status === 0,
        'status-processing': status === 1,
        'status-done': status === 2,
        'status-rejected': status === 3
      }
    }
  }
}
</script>

<style scoped>
.refund-page-inner {
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

.empty-state {
  text-align: center;
  padding: 80px 0;
  color: var(--color-text-muted);
}
.empty-state p {
  margin-top: 16px;
  font-size: 14px;
}

.refund-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.refund-card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 20px;
  cursor: pointer;
  transition: box-shadow 0.2s;
}
.refund-card:hover {
  box-shadow: var(--shadow-sm);
}

.refund-header {
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
.refund-no {
  font-weight: 600;
  font-size: 14px;
}
.refund-time {
  font-size: 12px;
  color: var(--color-text-muted);
}
.refund-status {
  font-size: 14px;
  font-weight: 600;
}
.status-pending { color: #ff976a; }
.status-processing { color: #1989fa; }
.status-done { color: #07c160; }
.status-rejected { color: #ee0a24; }

.refund-body {
  display: flex;
  flex-direction: column;
  gap: 12px;
}
.info-row {
  display: flex;
  align-items: center;
  font-size: 14px;
}
.info-row .label {
  color: var(--color-text-muted);
  width: 80px;
}
.info-row .value {
  color: var(--color-text-main);
  font-weight: 500;
}
.info-row .price {
  color: #ee0a24;
  font-size: 16px;
}

@media (max-width: 767px) {
  .refund-page-inner {
    padding: 16px 0;
  }
  .page-title {
    display: none;
  }
  .refund-card {
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
