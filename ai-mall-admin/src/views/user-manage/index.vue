<template>
  <div class="page-container">
    <el-card>
      <el-form :inline="true" :model="query" size="small">
        <el-form-item label="用户名">
          <el-input v-model="query.username" placeholder="用户名" clearable />
        </el-form-item>
        <el-form-item label="手机号">
          <el-input v-model="query.phone" placeholder="手机号" clearable />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="query.status" placeholder="全部" clearable>
            <el-option label="正常" :value="1" />
            <el-option label="禁用" :value="0" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
        </el-form-item>
      </el-form>

      <el-table :data="list" v-loading="loading" border>
        <el-table-column prop="id" label="ID" width="80" align="center" />
        <el-table-column prop="username" label="用户名" min-width="120" />
        <el-table-column prop="nickname" label="昵称" min-width="120" />
        <el-table-column prop="phone" label="手机号" width="130" />
        <el-table-column prop="status" label="状态" width="90" align="center">
          <template slot-scope="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '正常' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="注册时间" width="160" align="center" />
        <el-table-column label="操作" width="150" align="center">
          <template slot-scope="{ row }">
            <el-button type="text" @click="openDetail(row)">详情</el-button>
            <el-button
              type="text"
              :class="{ 'text-danger': row.status === 1 }"
              @click="toggleStatus(row)"
            >{{ row.status === 1 ? '禁用' : '启用' }}</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        style="margin-top:16px;text-align:right"
        background
        layout="total, prev, pager, next"
        :total="total"
        :page-size="query.pageSize"
        :current-page.sync="query.pageNum"
        @current-change="loadData"
      />
    </el-card>

    <el-drawer title="用户详情" :visible.sync="detailVisible" size="480px">
      <div v-loading="detailLoading" class="detail-body">
        <template v-if="detail">
          <div class="base-info">
            <el-avatar :size="64" :src="detail.avatar || undefined" icon="el-icon-user-solid" />
            <div class="base-text">
              <p><b>ID：</b>{{ detail.id }}</p>
              <p><b>用户名：</b>{{ detail.username }}</p>
              <p><b>昵称：</b>{{ detail.nickname || '-' }}</p>
              <p><b>手机号：</b>{{ detail.phone || '-' }}</p>
              <p>
                <b>状态：</b>
                <el-tag size="small" :type="detail.status === 1 ? 'success' : 'danger'">
                  {{ detail.status === 1 ? '正常' : '禁用' }}
                </el-tag>
              </p>
              <p><b>注册时间：</b>{{ detail.createTime }}</p>
            </div>
          </div>
          <div class="stat-cards">
            <div class="stat-card">
              <div class="stat-value">{{ stat.orderCount }}</div>
              <div class="stat-label">订单数</div>
            </div>
            <div class="stat-card">
              <div class="stat-value">{{ stat.totalSpent }}</div>
              <div class="stat-label">消费总额</div>
            </div>
            <div class="stat-card">
              <div class="stat-value">{{ stat.refundCount }}</div>
              <div class="stat-label">退款数</div>
            </div>
            <div class="stat-card">
              <div class="stat-value">{{ stat.ticketCount }}</div>
              <div class="stat-label">工单数</div>
            </div>
          </div>
        </template>
      </div>
    </el-drawer>
  </div>
</template>

<script>
import { getUserList, getUserDetail, updateUserStatus } from '@/api/user'

export default {
  name: 'UserManage',
  data() {
    return {
      query: { username: '', phone: '', status: null, pageNum: 1, pageSize: 10 },
      list: [],
      total: 0,
      loading: false,
      detailVisible: false,
      detailLoading: false,
      detail: null
    }
  },
  computed: {
    stat() {
      const d = this.detail || {}
      return {
        orderCount: d.orderCount != null ? d.orderCount : 0,
        totalSpent: d.totalPayAmount != null ? d.totalPayAmount : 0,
        refundCount: d.refundCount != null ? d.refundCount : 0,
        ticketCount: d.ticketCount != null ? d.ticketCount : 0
      }
    }
  },
  created() {
    this.loadData()
  },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const res = await getUserList({
          username: this.query.username || undefined,
          phone: this.query.phone || undefined,
          status: this.query.status,
          pageNum: this.query.pageNum,
          pageSize: this.query.pageSize
        })
        this.list = res.data.list || []
        this.total = res.data.total || 0
      } finally {
        this.loading = false
      }
    },
    handleSearch() {
      this.query.pageNum = 1
      this.loadData()
    },
    async toggleStatus(row) {
      const disabling = row.status === 1
      const tip = disabling
        ? '确定要禁用该用户吗？禁用后将强制用户下线。'
        : '确定要启用该用户吗？'
      try {
        await this.$confirm(tip, '提示', { type: 'warning' })
      } catch (e) {
        return
      }
      await updateUserStatus(row.id, disabling ? 0 : 1)
      this.$message.success(disabling ? '已禁用' : '已启用')
      this.loadData()
    },
    async openDetail(row) {
      this.detailVisible = true
      this.detailLoading = true
      this.detail = null
      try {
        const res = await getUserDetail(row.id)
        this.detail = res.data
      } finally {
        this.detailLoading = false
      }
    }
  }
}
</script>

<style scoped>
.page-container { padding: 0; }
.text-danger { color: #f56c6c; }
.detail-body { padding: 0 20px 20px; min-height: 200px; }
.base-info { display: flex; gap: 16px; }
.base-text p { margin: 4px 0; color: #606266; font-size: 14px; }
.stat-cards { display: flex; gap: 12px; margin-top: 24px; }
.stat-card { flex: 1; text-align: center; padding: 16px 8px; background: #f5f7fa; border-radius: 4px; }
.stat-value { font-size: 20px; font-weight: bold; color: #303133; }
.stat-label { margin-top: 6px; font-size: 13px; color: #909399; }
</style>
