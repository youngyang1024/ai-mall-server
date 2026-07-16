<template>
  <div class="page-container faq-page">
    <el-card class="category-panel">
      <div slot="header" class="panel-header">
        <span>分类</span>
        <el-button type="text" icon="el-icon-plus" @click="openCategoryDialog()">新增</el-button>
      </div>
      <div v-loading="categoryLoading">
        <div
          v-for="cat in categories"
          :key="cat.id"
          class="category-item"
          :class="{ active: currentCategoryId === cat.id }"
          @click="selectCategory(cat)"
        >
          <span class="category-name">
            {{ cat.name }}
            <el-tag v-if="cat.status === 0" size="mini" type="danger">禁用</el-tag>
          </span>
          <span class="category-actions" @click.stop>
            <el-button type="text" size="mini" icon="el-icon-edit" @click="openCategoryDialog(cat)" />
            <el-button type="text" size="mini" icon="el-icon-delete" class="text-danger" @click="handleDeleteCategory(cat)" />
          </span>
        </div>
        <div v-if="!categoryLoading && !categories.length" class="empty-tip">暂无分类，请先新增</div>
      </div>
    </el-card>

    <el-card class="article-panel">
      <div slot="header" class="panel-header">
        <span>文章{{ currentCategory ? ` - ${currentCategory.name}` : '' }}</span>
        <el-button type="primary" size="small" :disabled="!categories.length" @click="openArticleDialog()">新增文章</el-button>
      </div>
      <el-table :data="articles" v-loading="articleLoading" border>
        <el-table-column prop="id" label="ID" width="70" align="center" />
        <el-table-column prop="title" label="标题" min-width="200" />
        <el-table-column prop="sort" label="排序" width="80" align="center" />
        <el-table-column prop="status" label="状态" width="90" align="center">
          <template slot-scope="{ row }">
            <el-tag :type="row.status === 1 ? 'success' : 'danger'">
              {{ row.status === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="160" align="center" />
        <el-table-column label="操作" width="120" align="center">
          <template slot-scope="{ row }">
            <el-button type="text" @click="openArticleDialog(row)">编辑</el-button>
            <el-button type="text" class="text-danger" @click="handleDeleteArticle(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
      <el-pagination
        style="margin-top:16px;text-align:right"
        background
        layout="total, prev, pager, next"
        :total="articleTotal"
        :page-size="articleQuery.pageSize"
        :current-page.sync="articleQuery.pageNum"
        @current-change="loadArticles"
      />
    </el-card>

    <el-dialog
      :title="categoryForm.id ? '编辑分类' : '新增分类'"
      :visible.sync="categoryDialogVisible"
      width="450px"
      @closed="$refs.categoryForm.resetFields()"
    >
      <el-form ref="categoryForm" :model="categoryForm" :rules="categoryRules" label-width="80px">
        <el-form-item label="名称" prop="name">
          <el-input v-model="categoryForm.name" placeholder="请输入分类名称" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number v-model="categoryForm.sort" :min="0" :max="999" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-switch v-model="categoryForm.status" :active-value="1" :inactive-value="0" />
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="categoryDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitCategory">确定</el-button>
      </div>
    </el-dialog>

    <el-dialog
      :title="articleForm.id ? '编辑文章' : '新增文章'"
      :visible.sync="articleDialogVisible"
      width="640px"
      @closed="$refs.articleForm.resetFields()"
    >
      <el-form ref="articleForm" :model="articleForm" :rules="articleRules" label-width="80px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="articleForm.title" placeholder="请输入标题" />
        </el-form-item>
        <el-form-item label="分类" prop="categoryId">
          <el-select v-model="articleForm.categoryId" placeholder="请选择分类" style="width:100%">
            <el-option v-for="cat in categories" :key="cat.id" :label="cat.name" :value="cat.id" />
          </el-select>
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input v-model="articleForm.content" type="textarea" :rows="10" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="排序" prop="sort">
          <el-input-number v-model="articleForm.sort" :min="0" :max="999" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-switch v-model="articleForm.status" :active-value="1" :inactive-value="0" />
        </el-form-item>
      </el-form>
      <div slot="footer">
        <el-button @click="articleDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitArticle">确定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import {
  getFaqCategoryList, saveFaqCategory, updateFaqCategory, deleteFaqCategory,
  getFaqArticleList, saveFaqArticle, updateFaqArticle, deleteFaqArticle
} from '@/api/faq'

export default {
  name: 'FaqManage',
  data() {
    return {
      categories: [],
      categoryLoading: false,
      currentCategoryId: null,
      articles: [],
      articleTotal: 0,
      articleLoading: false,
      articleQuery: { pageNum: 1, pageSize: 10 },
      categoryDialogVisible: false,
      categoryForm: { id: null, name: '', sort: 0, status: 1 },
      categoryRules: {
        name: [{ required: true, message: '请输入分类名称', trigger: 'blur' }]
      },
      articleDialogVisible: false,
      articleForm: { id: null, categoryId: null, title: '', content: '', sort: 0, status: 1 },
      articleRules: {
        title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
        categoryId: [{ required: true, message: '请选择分类', trigger: 'change' }],
        content: [{ required: true, message: '请输入内容', trigger: 'blur' }]
      }
    }
  },
  computed: {
    currentCategory() {
      return this.categories.find(c => c.id === this.currentCategoryId) || null
    }
  },
  created() {
    this.loadCategories()
  },
  methods: {
    async loadCategories(keepCurrent) {
      this.categoryLoading = true
      try {
        const res = await getFaqCategoryList({ pageNum: 1, pageSize: 100 })
        this.categories = (res.data && res.data.list) || []
        const exists = this.categories.some(c => c.id === this.currentCategoryId)
        if (!keepCurrent || !exists) {
          this.currentCategoryId = this.categories.length ? this.categories[0].id : null
          this.articleQuery.pageNum = 1
        }
        this.loadArticles()
      } finally {
        this.categoryLoading = false
      }
    },
    selectCategory(cat) {
      if (this.currentCategoryId === cat.id) return
      this.currentCategoryId = cat.id
      this.articleQuery.pageNum = 1
      this.loadArticles()
    },
    async loadArticles() {
      if (!this.currentCategoryId) {
        this.articles = []
        this.articleTotal = 0
        return
      }
      this.articleLoading = true
      try {
        const res = await getFaqArticleList({
          categoryId: this.currentCategoryId,
          pageNum: this.articleQuery.pageNum,
          pageSize: this.articleQuery.pageSize
        })
        this.articles = (res.data && res.data.list) || []
        this.articleTotal = (res.data && res.data.total) || 0
      } finally {
        this.articleLoading = false
      }
    },
    openCategoryDialog(cat) {
      this.categoryForm = cat
        ? { id: cat.id, name: cat.name, sort: cat.sort || 0, status: cat.status }
        : { id: null, name: '', sort: 0, status: 1 }
      this.categoryDialogVisible = true
    },
    submitCategory() {
      this.$refs.categoryForm.validate(async valid => {
        if (!valid) return
        if (this.categoryForm.id) {
          await updateFaqCategory(this.categoryForm)
        } else {
          await saveFaqCategory(this.categoryForm)
        }
        this.$message.success('保存成功')
        this.categoryDialogVisible = false
        this.loadCategories(true)
      })
    },
    async handleDeleteCategory(cat) {
      try {
        await this.$confirm(`确定要删除分类「${cat.name}」吗？`, '提示', { type: 'warning' })
      } catch (e) {
        return
      }
      await deleteFaqCategory(cat.id)
      this.$message.success('删除成功')
      this.loadCategories()
    },
    openArticleDialog(row) {
      this.articleForm = row
        ? { id: row.id, categoryId: row.categoryId, title: row.title, content: row.content, sort: row.sort || 0, status: row.status }
        : { id: null, categoryId: this.currentCategoryId, title: '', content: '', sort: 0, status: 1 }
      this.articleDialogVisible = true
    },
    submitArticle() {
      this.$refs.articleForm.validate(async valid => {
        if (!valid) return
        if (this.articleForm.id) {
          await updateFaqArticle(this.articleForm)
        } else {
          await saveFaqArticle(this.articleForm)
        }
        this.$message.success('保存成功')
        this.articleDialogVisible = false
        this.loadArticles()
      })
    },
    async handleDeleteArticle(row) {
      try {
        await this.$confirm(`确定要删除文章「${row.title}」吗？`, '提示', { type: 'warning' })
      } catch (e) {
        return
      }
      await deleteFaqArticle(row.id)
      this.$message.success('删除成功')
      this.loadArticles()
    }
  }
}
</script>

<style scoped>
.faq-page { display: flex; gap: 16px; align-items: flex-start; }
.category-panel { width: 260px; flex-shrink: 0; }
.article-panel { flex: 1; min-width: 0; }
.panel-header { display: flex; align-items: center; justify-content: space-between; }
.category-item { display: flex; align-items: center; justify-content: space-between; padding: 8px 10px; border-radius: 4px; cursor: pointer; color: #606266; }
.category-item:hover { background: #f5f7fa; }
.category-item.active { background: #ecf5ff; color: #409eff; }
.category-name { flex: 1; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.category-actions { flex-shrink: 0; }
.empty-tip { padding: 20px 0; text-align: center; color: #909399; font-size: 13px; }
.text-danger { color: #f56c6c; }
</style>
