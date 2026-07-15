<template>
  <div>
    <el-card>
      <div slot="header" class="clearfix">
        <span>商品管理</span>
        <el-button style="float: right" type="primary" size="small" @click="$router.push('/product/add')">新增商品</el-button>
      </div>
      <el-form :inline="true" size="small">
        <el-form-item label="商品名称"><el-input v-model="query.name" clearable /></el-form-item>
        <el-form-item label="状态">
          <el-select v-model="query.status" clearable placeholder="全部">
            <el-option label="上架" :value="1" /><el-option label="下架" :value="0" />
          </el-select>
        </el-form-item>
        <el-form-item><el-button type="primary" @click="loadData">查询</el-button></el-form-item>
      </el-form>
      <el-table :data="list" border>
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column label="主图" width="80">
          <template slot-scope="{ row }"><el-image v-if="row.mainImage" :src="row.mainImage" style="width:50px;height:50px" fit="cover" /></template>
        </el-table-column>
        <el-table-column prop="name" label="商品名称" />
        <el-table-column prop="categoryName" label="分类" width="120" />
        <el-table-column label="状态" width="80">
          <template slot-scope="{ row }">{{ row.status === 1 ? '上架' : '下架' }}</template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template slot-scope="{ row }">
            <el-button type="text" @click="$router.push(`/product/edit/${row.id}`)">编辑</el-button>
            <el-button type="text" @click="toggleStatus(row)">{{ row.status === 1 ? '下架' : '上架' }}</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination style="margin-top:16px;text-align:right" background layout="total, prev, pager, next"
        :total="total" :page-size="query.pageSize" :current-page.sync="query.pageNum" @current-change="loadData" />
    </el-card>
  </div>
</template>

<script>
import { getProductList, updateProductStatus } from '@/api/product'

export default {
  name: 'ProductList',
  data() {
    return { list: [], total: 0, query: { pageNum: 1, pageSize: 10, name: '', status: null } }
  },
  created() { this.loadData() },
  methods: {
    async loadData() {
      const res = await getProductList(this.query)
      this.list = res.data.list
      this.total = res.data.total
    },
    async toggleStatus(row) {
      const status = row.status === 1 ? 0 : 1
      await updateProductStatus(row.id, status)
      this.$message.success('操作成功')
      this.loadData()
    }
  }
}
</script>
