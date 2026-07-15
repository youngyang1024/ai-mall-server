<template>
  <div>
    <el-card>
      <el-form :inline="true" :model="query" size="small">
        <el-form-item label="状态">
          <el-select v-model="query.status" placeholder="全部" clearable>
            <el-option label="待审核" :value="0" />
            <el-option label="已通过" :value="1" />
            <el-option label="已拒绝" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="loadData">查询</el-button>
        </el-form-item>
      </el-form>

      <el-table :data="list" v-loading="loading" border>
        <el-table-column prop="refundNo" label="退款单号" min-width="160" />
        <el-table-column prop="orderNo" label="订单号" min-width="160" />
        <el-table-column prop="userId" label="用户ID" width="90" />
        <el-table-column prop="refundAmount" label="退款金额" width="100" />
        <el-table-column prop="statusDesc" label="状态" width="90" />
        <el-table-column prop="createTime" label="申请时间" min-width="160" />
        <el-table-column label="操作" width="200" fixed="right">
          <template slot-scope="{ row }">
            <el-button type="text" @click="openDetail(row)">详情</el-button>
            <template v-if="row.status === 0">
              <el-button type="text" @click="handleApprove(row)">通过</el-button>
              <el-button type="text" style="color:#f56c6c" @click="openReject(row)">拒绝</el-button>
            </template>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        style="margin-top:16px;text-align:right"
        :current-page="pageNum"
        :page-size="pageSize"
        :total="total"
        layout="total, prev, pager, next"
        @current-change="handlePageChange"
      />
    </el-card>

    <el-dialog title="退款详情" :visible.sync="detailVisible" width="560px">
      <div v-if="detail">
        <p><b>退款单号：</b>{{ detail.refundNo }}</p>
        <p><b>订单号：</b>{{ detail.orderNo }}</p>
        <p><b>退款金额：</b>¥{{ detail.refundAmount }}</p>
        <p><b>申请原因：</b>{{ detail.reason }}</p>
        <p v-if="detail.rejectReason"><b>拒绝原因：</b>{{ detail.rejectReason }}</p>
      </div>
    </el-dialog>

    <el-dialog title="拒绝退款" :visible.sync="rejectVisible" width="400px">
      <el-input v-model="rejectReason" type="textarea" rows="3" placeholder="请输入拒绝原因" />
      <span slot="footer">
        <el-button @click="rejectVisible = false">取消</el-button>
        <el-button type="primary" @click="submitReject">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getRefundList, getRefundDetail, approveRefund, rejectRefund } from '@/api/refund'

export default {
  name: 'RefundPage',
  data() {
    return {
      query: { status: null },
      list: [],
      loading: false,
      pageNum: 1,
      pageSize: 10,
      total: 0,
      detailVisible: false,
      detail: null,
      rejectVisible: false,
      rejectReason: '',
      currentRow: null
    }
  },
  created() { this.loadData() },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const res = await getRefundList({
          status: this.query.status,
          pageNum: this.pageNum,
          pageSize: this.pageSize
        })
        this.list = res.data.list || []
        this.total = res.data.total || 0
      } finally {
        this.loading = false
      }
    },
    handlePageChange(page) {
      this.pageNum = page
      this.loadData()
    },
    async openDetail(row) {
      const res = await getRefundDetail(row.id)
      this.detail = res.data
      this.detailVisible = true
    },
    async handleApprove(row) {
      await this.$confirm('确认通过该退款申请？')
      await approveRefund(row.id)
      this.$message.success('已通过')
      this.loadData()
    },
    openReject(row) {
      this.currentRow = row
      this.rejectReason = ''
      this.rejectVisible = true
    },
    async submitReject() {
      if (!this.rejectReason.trim()) {
        this.$message.warning('请输入拒绝原因')
        return
      }
      await rejectRefund(this.currentRow.id, { rejectReason: this.rejectReason })
      this.$message.success('已拒绝')
      this.rejectVisible = false
      this.loadData()
    }
  }
}
</script>
