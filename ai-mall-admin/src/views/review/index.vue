<template>
  <div class="page-container">
    <el-card>
      <el-form :inline="true" :model="query" size="small">
        <el-form-item label="商品ID">
          <el-input v-model="query.spuId" placeholder="商品ID" clearable />
        </el-form-item>
        <el-form-item label="评分">
          <el-select v-model="query.rating" placeholder="全部" clearable>
            <el-option v-for="n in 5" :key="n" :label="`${n} 星`" :value="n" />
          </el-select>
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="query.status" placeholder="全部" clearable>
            <el-option label="显示" :value="1" />
            <el-option label="隐藏" :value="0" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
        </el-form-item>
      </el-form>

      <el-table :data="list" v-loading="loading" border>
        <el-table-column prop="id" label="ID" width="70" align="center" />
        <el-table-column prop="spuName" label="商品名" min-width="150" show-overflow-tooltip />
        <el-table-column label="用户" width="120">
          <template slot-scope="{ row }">{{ row.nickname || `用户${row.userId}` }}</template>
        </el-table-column>
        <el-table-column label="评分" width="140" align="center">
          <template slot-scope="{ row }">
            <el-rate :value="row.rating" disabled />
          </template>
        </el-table-column>
        <el-table-column prop="content" label="内容" min-width="200" show-overflow-tooltip />
        <el-table-column label="晒图" width="150">
          <template slot-scope="{ row }">
            <el-image
              v-for="(img, i) in (row.images || [])"
              :key="i"
              :src="img"
              :preview-src-list="row.images"
              fit="cover"
              class="review-img"
            />
          </template>
        </el-table-column>
        <el-table-column label="规格" width="120" show-overflow-tooltip>
          <template slot-scope="{ row }">{{ formatSpec(row.skuSpec) }}</template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="80" align="center">
          <template slot-scope="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'info'">
              {{ row.status === 1 ? '显示' : '隐藏' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="时间" width="160" align="center" />
        <el-table-column label="操作" width="90" align="center" fixed="right">
          <template slot-scope="{ row }">
            <el-button
              type="text"
              :class="{ 'text-danger': row.status === 1 }"
              @click="toggleStatus(row)"
            >{{ row.status === 1 ? '隐藏' : '显示' }}</el-button>
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
  </div>
</template>

<script>
import { getReviewList, updateReviewStatus } from '@/api/review'

export default {
  name: 'ReviewManage',
  data() {
    return {
      query: { spuId: '', rating: null, status: null, pageNum: 1, pageSize: 10 },
      list: [],
      total: 0,
      loading: false
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
        const res = await getReviewList({
          spuId: this.query.spuId || undefined,
          rating: this.query.rating,
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
      const hiding = row.status === 1
      try {
        await this.$confirm(
          hiding ? '确定要隐藏该评价吗？隐藏后用户端不可见。' : '确定要显示该评价吗？',
          '提示',
          { type: 'warning' }
        )
      } catch (e) {
        return
      }
      await updateReviewStatus(row.id, hiding ? 0 : 1)
      this.$message.success('操作成功')
      this.loadData()
    }
  }
}
</script>

<style scoped>
.review-img { width: 40px; height: 40px; margin-right: 4px; border-radius: 2px; vertical-align: middle; }
.text-danger { color: #f56c6c; }
</style>
