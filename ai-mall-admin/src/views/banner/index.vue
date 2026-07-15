<template>
  <div>
    <el-card>
      <div slot="header" class="clearfix">
        <span>轮播图管理</span>
        <el-button style="float:right" type="primary" size="small" @click="openDialog()">新增轮播图</el-button>
      </div>
      <el-table :data="list" border>
        <el-table-column prop="title" label="标题" />
        <el-table-column label="图片" width="120">
          <template slot-scope="{ row }">
            <el-image v-if="row.imageUrl" :src="row.imageUrl" style="width:80px;height:40px" fit="cover" />
          </template>
        </el-table-column>
        <el-table-column prop="linkUrl" label="跳转链接" show-overflow-tooltip />
        <el-table-column prop="sort" label="排序" width="80" />
        <el-table-column label="状态" width="90">
          <template slot-scope="{ row }">{{ row.status === 1 ? '启用' : '禁用' }}</template>
        </el-table-column>
        <el-table-column label="操作" width="160">
          <template slot-scope="{ row }">
            <el-button type="text" @click="openDialog(row)">编辑</el-button>
            <el-button type="text" style="color:#f56c6c" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog :title="form.id ? '编辑轮播图' : '新增轮播图'" :visible.sync="dialogVisible" width="520px">
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="标题"><el-input v-model="form.title" /></el-form-item>
        <el-form-item label="图片URL" prop="imageUrl">
          <el-input v-model="form.imageUrl" placeholder="图片地址" />
          <el-upload :show-file-list="false" :http-request="uploadImage" style="margin-top:8px">
            <el-button size="small">上传图片</el-button>
          </el-upload>
        </el-form-item>
        <el-form-item label="跳转链接"><el-input v-model="form.linkUrl" /></el-form-item>
        <el-form-item label="排序"><el-input-number v-model="form.sort" :min="0" /></el-form-item>
        <el-form-item label="状态">
          <el-switch v-model="form.status" :active-value="1" :inactive-value="0" />
        </el-form-item>
      </el-form>
      <span slot="footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submit">确定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import { getBannerList, createBanner, updateBanner, deleteBanner } from '@/api/banner'
import { uploadFile } from '@/api/file'

export default {
  name: 'BannerPage',
  data() {
    return {
      list: [],
      dialogVisible: false,
      form: { id: null, title: '', imageUrl: '', linkUrl: '', sort: 0, status: 1 },
      rules: { imageUrl: [{ required: true, message: '请填写图片URL', trigger: 'blur' }] }
    }
  },
  created() { this.loadData() },
  methods: {
    async loadData() {
      const res = await getBannerList()
      this.list = res.data || []
    },
    openDialog(row) {
      this.form = row ? { ...row } : { id: null, title: '', imageUrl: '', linkUrl: '', sort: 0, status: 1 }
      this.dialogVisible = true
    },
    async uploadImage({ file }) {
      const res = await uploadFile(file)
      this.form.imageUrl = res.data.url
      this.$message.success('上传成功')
    },
    submit() {
      this.$refs.form.validate(async valid => {
        if (!valid) return
        if (this.form.id) await updateBanner(this.form.id, this.form)
        else await createBanner(this.form)
        this.$message.success('保存成功')
        this.dialogVisible = false
        this.loadData()
      })
    },
    async handleDelete(row) {
      await this.$confirm('确认删除该轮播图？')
      await deleteBanner(row.id)
      this.$message.success('已删除')
      this.loadData()
    }
  }
}
</script>
