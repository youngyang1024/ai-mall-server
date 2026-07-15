<template>
  <div class="ticket-list-page">
    <h1 class="page-title" v-if="!isMobile">我的工单</h1>

    <div v-if="!list.length && !loading" class="empty-state">
      <van-icon name="description" size="48" color="#d8d8d8" />
      <p>暂无工单记录</p>
      <button class="shopify-btn" @click="$router.push('/service-center')">提交新工单</button>
    </div>

    <div v-for="item in list" :key="item.ticketNo" class="ticket-card" @click="$router.push('/service-ticket/' + item.ticketNo)">
      <div class="ticket-header">
        <div>
          <div class="ticket-no">工单号：{{ item.ticketNo }}</div>
          <div class="ticket-time">{{ formatTime(item.createTime) }}</div>
        </div>
        <span class="status-badge" :class="'status-' + item.status">{{ item.statusDesc }}</span>
      </div>
      <div class="ticket-body">
        <div class="info-row"><span>问题分类</span><span>{{ item.categoryName }} / {{ item.issueName }}</span></div>
        <div class="info-row" v-if="item.orderNo"><span>订单号</span><span>{{ item.orderNo }}</span></div>
        <div class="info-row"><span>最近更新</span><span>{{ formatTime(item.updateTime) }}</span></div>
      </div>
    </div>
  </div>
</template>

<script>
import { getMyServiceTicketList } from '@/api/service-ticket'
import responsiveMixin from '@/mixins/responsive'

export default {
  name: 'ServiceTicketListPage',
  mixins: [responsiveMixin],
  data() {
    return {
      list: [],
      loading: false
    }
  },
  async created() {
    this.loading = true
    try {
      const res = await getMyServiceTicketList({ pageNum: 1, pageSize: 50 })
      this.list = res.data.list || []
    } finally {
      this.loading = false
    }
  },
  methods: {
    formatTime(value) {
      return value ? value.replace('T', ' ') : ''
    }
  }
}
</script>

<style scoped>
.ticket-list-page {
  max-width: 1000px;
  margin: 0 auto;
  padding: 40px 16px;
}
.page-title {
  margin: 0 0 28px;
  font-size: 28px;
  font-weight: 600;
}
.empty-state {
  text-align: center;
  padding: 90px 0;
  color: var(--color-text-muted);
}
.empty-state p {
  margin: 16px 0 22px;
}
.ticket-card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 20px;
  margin-bottom: 16px;
  cursor: pointer;
}
.ticket-card:hover {
  box-shadow: var(--shadow-sm);
}
.ticket-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 12px;
  margin-bottom: 16px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--color-surface);
}
.ticket-no {
  font-size: 16px;
  font-weight: 600;
}
.ticket-time {
  margin-top: 6px;
  color: var(--color-text-muted);
  font-size: 13px;
}
.status-badge {
  font-size: 13px;
  font-weight: 600;
}
.status-0 { color: #ff976a; }
.status-1 { color: #1989fa; }
.status-2 { color: #07c160; }
.ticket-body {
  display: flex;
  flex-direction: column;
  gap: 12px;
}
.info-row {
  display: flex;
  justify-content: space-between;
  gap: 16px;
  font-size: 14px;
}
.info-row span:first-child {
  color: var(--color-text-muted);
  flex-shrink: 0;
}
@media (max-width: 767px) {
  .ticket-list-page {
    padding: 12px 0;
  }
  .ticket-card {
    border-radius: 0;
    border-left: none;
    border-right: none;
  }
  .info-row {
    flex-direction: column;
    gap: 6px;
  }
}
</style>
