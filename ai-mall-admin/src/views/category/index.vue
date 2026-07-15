<template>
  <div class="category-container">
    <div class="header-actions">
      <el-button type="primary" size="small" @click="handleCreateTop">新增一级类目</el-button>
    </div>

    <el-row :gutter="20" class="main-content">
      <!-- 左侧分类树 -->
      <el-col :span="8">
        <el-card shadow="never" class="tree-card">
          <el-tree
            :data="tree"
            node-key="id"
            default-expand-all
            :expand-on-click-node="false"
            highlight-current
            @node-click="handleNodeClick"
          >
            <span class="custom-tree-node" slot-scope="{ node, data }">
              <span class="node-label">
                {{ data.name }}
                <el-tag v-if="data.status === 1" type="success" size="mini" effect="plain" class="status-tag">启用</el-tag>
                <el-tag v-else type="info" size="mini" effect="plain" class="status-tag">禁用</el-tag>
              </span>
              <span class="node-actions">
                <el-button type="text" size="mini" icon="el-icon-plus" @click.stop="handleCreateChild(data)" title="新增子分类"></el-button>
                <el-button type="text" size="mini" icon="el-icon-delete" style="color: #f56c6c;" @click.stop="handleDelete(data)" title="删除分类"></el-button>
              </span>
            </span>
          </el-tree>
        </el-card>
      </el-col>

      <!-- 右侧表单区 -->
      <el-col :span="16">
        <el-card shadow="never" class="form-card">
          <div slot="header" class="form-header">
            <span>{{ isEdit ? '编辑分类: ' + form.name : '新增分类' }}</span>
            <el-button type="primary" size="small" @click="submit">保存</el-button>
          </div>
          
          <el-form ref="form" :model="form" :rules="rules" label-width="120px" v-if="formVisible">
            <el-form-item label="所属父级分类" prop="parentId">
              <el-select v-model="form.parentId" style="width:100%" placeholder="请选择父级分类" :disabled="isEdit && form.parentId === 0">
                <el-option label="顶级分类" :value="0" />
                <el-option v-for="item in flatList" :key="item.id" :label="item.name" :value="item.id" :disabled="item.id === form.id" />
              </el-select>
            </el-form-item>
            
            <el-form-item label="类目名称" prop="name">
              <el-input v-model="form.name" placeholder="请输入分类名称" />
            </el-form-item>
            
            <el-form-item label="状态" prop="status">
              <el-switch v-model="form.status" :active-value="1" :inactive-value="0" active-text="启用" inactive-text="禁用" />
            </el-form-item>
            
            <el-form-item label="排序" prop="sort">
              <el-input-number v-model="form.sort" :min="0" controls-position="right" />
              <span class="sort-tip">数字越小越靠前</span>
            </el-form-item>
          </el-form>
          
          <el-empty v-else description="请在左侧选择要编辑的分类，或点击新增按钮" />
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getCategoryTree, createCategory, updateCategory, deleteCategory } from '@/api/category'

export default {
  name: 'CategoryPage',
  data() {
    return {
      tree: [],
      flatList: [],
      formVisible: false,
      isEdit: false,
      form: { id: null, name: '', parentId: 0, sort: 0, status: 1 },
      rules: { name: [{ required: true, message: '请输入分类名称', trigger: 'blur' }] }
    }
  },
  created() { 
    this.loadData() 
  },
  methods: {
    async loadData() {
      const res = await getCategoryTree()
      this.tree = res.data
      this.flatList = this.flatten(res.data)
    },
    flatten(list, result = []) {
      list.forEach(item => {
        result.push({ id: item.id, name: item.name, sort: item.sort, status: item.status, parentId: item.parentId })
        if (item.children && item.children.length) this.flatten(item.children, result)
      })
      return result
    },
    handleNodeClick(data) {
      this.isEdit = true
      this.form = { ...data }
      // remove children property from form
      delete this.form.children
      this.formVisible = true
      if (this.$refs.form) this.$refs.form.clearValidate()
    },
    handleCreateTop() {
      this.isEdit = false
      this.form = { id: null, name: '', parentId: 0, sort: 0, status: 1 }
      this.formVisible = true
      if (this.$refs.form) this.$refs.form.clearValidate()
    },
    handleCreateChild(parentData) {
      this.isEdit = false
      this.form = { id: null, name: '', parentId: parentData.id, sort: 0, status: 1 }
      this.formVisible = true
      if (this.$refs.form) this.$refs.form.clearValidate()
    },
    submit() {
      this.$refs.form.validate(async valid => {
        if (!valid) return
        if (this.isEdit) {
          await updateCategory(this.form.id, this.form)
        } else {
          await createCategory(this.form)
        }
        this.$message.success('保存成功')
        this.loadData()
      })
    },
    handleDelete(data) {
      this.$confirm(`确认删除分类 "${data.name}" 及其所有子分类？`, '危险操作', { 
        type: 'warning',
        confirmButtonText: '确定删除',
        confirmButtonClass: 'el-button--danger'
      }).then(async () => {
        await deleteCategory(data.id)
        this.$message.success('删除成功')
        if (this.form.id === data.id) {
          this.formVisible = false
        }
        this.loadData()
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.category-container {
  padding: 20px;
}
.header-actions {
  margin-bottom: 20px;
}
.tree-card, .form-card {
  min-height: calc(100vh - 160px);
}
.form-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  padding-right: 8px;
}
.node-label {
  display: flex;
  align-items: center;
}
.status-tag {
  margin-left: 8px;
  transform: scale(0.85);
}
.node-actions {
  display: none;
}
.el-tree-node__content:hover .node-actions {
  display: inline-block;
}
.sort-tip {
  margin-left: 10px;
  color: #909399;
  font-size: 12px;
}
</style>
