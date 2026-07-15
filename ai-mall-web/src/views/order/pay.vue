<template>
  <page-shell title="订单支付" :show-back="isMobile" narrow>
    <div v-if="order" class="auth-card">
      <div class="amount">
        <p>应付金额</p>
        <h2>¥{{ order.payAmount }}</h2>
        <p class="order-no">订单号：{{ order.orderNo }}</p>
      </div>
      <div class="actions" v-if="order.status === 0">
        <van-button block type="danger" round @click="handlePay">模拟支付</van-button>
        <van-button block plain type="default" round style="margin-top:12px" @click="handleCancel">取消订单</van-button>
      </div>
      <div class="actions" v-else>
        <van-button block type="primary" round @click="$router.replace('/order/' + order.orderNo)">查看订单</van-button>
      </div>
    </div>
  </page-shell>
</template>

<script>
import { getOrderDetail, payOrder, cancelOrder } from '@/api/order'

export default {
  name: 'PayPage',
  data() {
    return { order: null }
  },
  async created() {
    const orderNo = this.$route.query.orderNo
    if (!orderNo) {
      this.$router.replace('/order')
      return
    }
    const res = await getOrderDetail(orderNo)
    this.order = res.data
  },
  methods: {
    async handlePay() {
      await payOrder(this.order.orderNo)
      this.$toast.success('支付成功')
      this.$router.replace('/order/' + this.order.orderNo)
    },
    async handleCancel() {
      await this.$dialog.confirm({ title: '确认取消订单？' })
      await cancelOrder(this.order.orderNo)
      this.$toast.success('已取消')
      this.$router.replace('/order')
    }
  }
}
</script>

<style scoped>
.amount { text-align: center; padding-bottom: 16px; }
.amount p { color: #969799; margin: 0; }
.amount h2 { color: #ee0a24; font-size: 36px; margin: 12px 0; }
.order-no { font-size: 12px; }
.actions { margin-top: 8px; }
</style>
