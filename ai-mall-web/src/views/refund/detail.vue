<template>
  <page-shell title="退款详情" :show-back="isMobile" narrow>
    <div v-if="detail" class="auth-card">
      <van-cell-group inset>
        <van-cell title="退款单号" :value="detail.refundNo" />
        <van-cell title="订单号" :value="detail.orderNo" />
        <van-cell title="状态" :value="detail.statusDesc" />
        <van-cell title="退款金额" :value="'¥' + detail.refundAmount" />
        <van-cell title="申请原因" :value="detail.reason" />
        <van-cell v-if="detail.rejectReason" title="拒绝原因" :value="detail.rejectReason" />
        <van-cell title="申请时间" :value="detail.createTime" />
      </van-cell-group>
    </div>
  </page-shell>
</template>

<script>
import { getRefundDetail } from '@/api/refund'

export default {
  name: 'RefundDetailPage',
  data() {
    return { detail: null }
  },
  async created() {
    const res = await getRefundDetail(this.$route.params.id)
    this.detail = res.data
  }
}
</script>
