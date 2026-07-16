<template>
  <div class="order-page">
    <el-card>
      <el-form :inline="true" :model="query" size="small">
        <el-form-item label="订单号">
          <el-input v-model="query.orderNo" placeholder="订单号" clearable />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="query.status" placeholder="全部" clearable>
            <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
          </el-select>
        </el-form-item>
        <el-form-item label="用户ID">
          <el-input v-model="query.userId" placeholder="用户ID" clearable @input="query.userId = query.userId.replace(/\D/g, '')" />
        </el-form-item>
        <el-form-item label="下单时间">
          <el-date-picker
            v-model="query.dateRange"
            type="daterange"
            value-format="yyyy-MM-dd"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
          />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
        </el-form-item>
      </el-form>

      <el-table :data="list" v-loading="loading" border>
        <el-table-column prop="orderNo" label="订单号" min-width="180" />
        <el-table-column prop="userId" label="用户ID" width="90" />
        <el-table-column prop="payAmount" label="实付金额" width="100" />
        <el-table-column prop="statusDesc" label="状态" width="100" />
        <el-table-column prop="createTime" label="下单时间" min-width="160" />
        <el-table-column label="操作" width="160" fixed="right">
          <template slot-scope="{ row }">
            <el-button type="text" @click="openDetail(row.orderNo)">详情</el-button>
            <el-button v-if="row.status === 1" type="text" @click="openShip(row)">发货</el-button>
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

    <el-dialog title="订单详情" :visible.sync="detailVisible" width="700px">
      <div v-if="detail">
        <p><b>订单号：</b>{{ detail.orderNo }}</p>
        <p><b>状态：</b>{{ detail.statusDesc }}</p>
        <p><b>收货信息：</b>{{ receiverText }}</p>
        <p v-if="detail.logisticsNo"><b>物流单号：</b>{{ detail.logisticsNo }}</p>
        <el-table :data="detail.items" border size="small" style="margin-top:12px">
          <el-table-column prop="spuName" label="商品" />
          <el-table-column label="规格">
            <template slot-scope="{ row }">{{ formatSpec(row.skuSpec) }}</template>
          </el-table-column>
          <el-table-column prop="price" label="单价" width="90" />
          <el-table-column prop="quantity" label="数量" width="70" />
        </el-table>
      </div>
    </el-dialog>

    <el-dialog title="发货" :visible.sync="shipVisible" width="400px">
      <el-form :model="shipForm" label-width="90px">
        <el-form-item label="物流单号">
          <el-input v-model="shipForm.logisticsNo" placeholder="请输入物流单号" />
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="shipVisible = false">取消</el-button>
        <el-button type="primary" @click="submitShip">确认发货</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getOrderList, getOrderDetail, shipOrder } from '@/api/order'

export default {
  name: 'OrderList',
  data() {
    return {
      query: { orderNo: '', status: null, userId: '', dateRange: null },
      list: [],
      loading: false,
      pageNum: 1,
      pageSize: 10,
      total: 0,
      statusOptions: [
        { value: 0, label: '待支付' },
        { value: 1, label: '待发货' },
        { value: 2, label: '已发货' },
        { value: 3, label: '已完成' },
        { value: 4, label: '已取消' }
      ],
      detailVisible: false,
      detail: null,
      shipVisible: false,
      shipForm: { orderNo: '', logisticsNo: '' }
    }
  },
  computed: {
    receiverText() {
      if (!this.detail || !this.detail.receiverInfo) return ''
      try {
        const r = JSON.parse(this.detail.receiverInfo)
        return `${r.receiverName} ${r.receiverPhone} ${[r.province, r.city, r.district, r.detail].filter(Boolean).join('')}`
      } catch (e) {
        return this.detail.receiverInfo
      }
    }
  },
  created() {
    this.loadData()
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
    async loadData() {
      this.loading = true
      try {
        const [startDate, endDate] = this.query.dateRange || []
        const res = await getOrderList({
          orderNo: this.query.orderNo || undefined,
          status: this.query.status,
          userId: this.query.userId || undefined,
          startTime: startDate ? `${startDate} 00:00:00` : undefined,
          endTime: endDate ? `${endDate} 23:59:59` : undefined,
          pageNum: this.pageNum,
          pageSize: this.pageSize
        })
        this.list = res.data.list || []
        this.total = res.data.total || 0
      } finally {
        this.loading = false
      }
    },
    handleSearch() {
      this.pageNum = 1
      this.loadData()
    },
    handlePageChange(page) {
      this.pageNum = page
      this.loadData()
    },
    async openDetail(orderNo) {
      const res = await getOrderDetail(orderNo)
      this.detail = res.data
      this.detailVisible = true
    },
    openShip(row) {
      this.shipForm = { orderNo: row.orderNo, logisticsNo: '' }
      this.shipVisible = true
    },
    async submitShip() {
      if (!this.shipForm.logisticsNo) {
        this.$message.warning('请输入物流单号')
        return
      }
      await shipOrder(this.shipForm.orderNo, { logisticsNo: this.shipForm.logisticsNo })
      this.$message.success('发货成功')
      this.shipVisible = false
      this.loadData()
    }
  }
}
</script>
