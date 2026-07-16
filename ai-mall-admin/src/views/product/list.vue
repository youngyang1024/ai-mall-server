<template>
  <div>
    <el-card>
      <div slot="header" class="clearfix">
        <span>商品管理</span>
        <el-button style="float: right" type="primary" size="small" @click="$router.push('/product/add')">新增商品</el-button>
      </div>
      <el-form :inline="true" size="small">
        <el-form-item label="商品ID"><el-input v-model="query.id" clearable style="width: 120px" @input="query.id = query.id.replace(/[^\d]/g, '')" /></el-form-item>
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
            <el-button type="text" @click="openStockDialog(row)">库存</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination style="margin-top:16px;text-align:right" background layout="total, prev, pager, next"
        :total="total" :page-size="query.pageSize" :current-page.sync="query.pageNum" @current-change="loadData" />
    </el-card>

    <el-dialog :title="`库存调整 - ${stockSpuName}`" :visible.sync="stockDialogVisible" width="700px">
      <el-table :data="stockSkus" v-loading="stockLoading" border size="small">
        <el-table-column label="规格">
          <template slot-scope="{ row }">{{ formatSpec(row.specJson) }}</template>
        </el-table-column>
        <el-table-column prop="price" label="价格" width="100" align="center" />
        <el-table-column label="库存" width="160" align="center">
          <template slot-scope="{ row }">
            <el-input-number v-model="row.stock" :min="0" size="small" style="width:120px" />
          </template>
        </el-table-column>
        <el-table-column label="操作" width="90" align="center">
          <template slot-scope="{ row }">
            <el-button type="text" :loading="row.saving" @click="saveSkuStock(row)">保存</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-dialog>
  </div>
</template>

<script>
import { getProductList, updateProductStatus, getProductDetail, updateSkuStock } from '@/api/product'

export default {
  name: 'ProductList',
  data() {
    return {
      list: [], total: 0, query: { pageNum: 1, pageSize: 10, id: '', name: '', status: null },
      stockDialogVisible: false, stockLoading: false, stockSpuId: null, stockSpuName: '', stockSkus: []
    }
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
    },
    formatSpec(specJsonStr) {
      if (!specJsonStr) return ''
      try {
        const obj = JSON.parse(specJsonStr)
        return Object.entries(obj).map(([k, v]) => `${k}: ${v}`).join(' | ')
      } catch (e) {
        return specJsonStr
      }
    },
    openStockDialog(row) {
      this.stockSpuId = row.id
      this.stockSpuName = row.name
      this.stockSkus = []
      this.stockDialogVisible = true
      this.loadStockSkus()
    },
    async loadStockSkus() {
      this.stockLoading = true
      try {
        const res = await getProductDetail(this.stockSpuId)
        this.stockSkus = (res.data.skus || []).map(s => ({ ...s, saving: false }))
      } finally {
        this.stockLoading = false
      }
    },
    async saveSkuStock(row) {
      if (row.stock == null || row.stock < 0) {
        this.$message.warning('请输入合法库存')
        return
      }
      row.saving = true
      try {
        await updateSkuStock(row.id, row.stock)
        this.$message.success('库存已更新')
        this.loadStockSkus()
        this.loadData()
      } finally {
        row.saving = false
      }
    }
  }
}
</script>
