<template>
  <div class="page-container">
    <div class="toolbar">
      <el-button type="primary" @click="openDialog()">新增热搜</el-button>
    </div>

    <el-table :data="list" v-loading="loading" border>
      <el-table-column prop="id" label="ID" width="80" align="center" />
      <el-table-column prop="keyword" label="关键词" />
      <el-table-column prop="isHot" label="显示 🔥 图标" width="150" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.isHot === 1 ? 'danger' : 'info'">
            {{ scope.row.isHot === 1 ? '是' : '否' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="sort" label="排序" width="100" align="center" />
      <el-table-column prop="status" label="状态" width="100" align="center">
        <template slot-scope="scope">
          <el-tag :type="scope.row.status === 1 ? 'success' : 'danger'">
            {{ scope.row.status === 1 ? '启用' : '禁用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="createTime" label="创建时间" width="160" align="center" />
      <el-table-column label="操作" width="150" align="center">
        <template slot-scope="scope">
          <el-button type="text" @click="openDialog(scope.row)">编辑</el-button>
          <el-button type="text" class="text-danger" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="form.id ? '编辑热搜' : '新增热搜'" :visible.sync="dialogVisible" width="500px" @closed="$refs.form.resetFields()">
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <el-form-item label="关键词" prop="keyword">
          <el-input v-model="form.keyword" placeholder="请输入关键词" />
        </el-form-item>
        <el-form-item label="显示 🔥 图标" prop="isHot">
          <el-switch v-model="form.isHot" :active-value="1" :inactive-value="0" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number v-model="form.sort" :min="0" :max="999" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-switch v-model="form.status" :active-value="1" :inactive-value="0" />
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getHotSearchList, createHotSearch, updateHotSearch, deleteHotSearch } from '@/api/hot-search'

export default {
  name: 'HotSearchList',
  data() {
    return {
      list: [],
      loading: false,
      dialogVisible: false,
      form: {
        id: null,
        keyword: '',
        isHot: 0,
        sort: 0,
        status: 1
      },
      rules: {
        keyword: [{ required: true, message: '请输入关键词', trigger: 'blur' }]
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
        const res = await getHotSearchList()
        this.list = res.data || []
      } finally {
        this.loading = false
      }
    },
    openDialog(row) {
      if (row) {
        this.form = { ...row }
      } else {
        this.form = { id: null, keyword: '', isHot: 0, sort: 0, status: 1 }
      }
      this.dialogVisible = true
    },
    handleSubmit() {
      this.$refs.form.validate(async valid => {
        if (!valid) return
        if (this.form.id) {
          await updateHotSearch(this.form)
        } else {
          await createHotSearch(this.form)
        }
        this.$message.success('保存成功')
        this.dialogVisible = false
        this.loadData()
      })
    },
    async handleDelete(id) {
      try {
        await this.$confirm('确定要删除该热搜记录吗？', '提示', { type: 'warning' })
        await deleteHotSearch(id)
        this.$message.success('删除成功')
        this.loadData()
      } catch (e) {
        // cancelled
      }
    }
  }
}
</script>

<style scoped>
.page-container { padding: 20px; }
.toolbar { margin-bottom: 16px; }
.text-danger { color: #f56c6c; }
</style>
