<template>
  <el-card>
    <div slot="header">{{ isEdit ? '编辑商品' : '新增商品' }}</div>
    <el-form ref="form" :model="form" :rules="rules" label-width="100px">
      <el-form-item label="商品名称" prop="name"><el-input v-model="form.name" /></el-form-item>
      <el-form-item label="分类" prop="categoryId">
        <el-cascader
          v-model="form.categoryId"
          :options="categoryTree"
          :props="{ value: 'id', label: 'name', children: 'children', emitPath: false, checkStrictly: true }"
          placeholder="请选择分类"
          style="width: 100%"
          filterable
          clearable
        />
      </el-form-item>
      <el-form-item label="主图">
        <el-upload action="#" :show-file-list="false" :http-request="uploadMain">
          <el-image v-if="form.mainImage" :src="form.mainImage" style="width:100px;height:100px" fit="cover" />
          <el-button v-else size="small" type="primary">上传主图</el-button>
        </el-upload>
      </el-form-item>
      <el-form-item label="商品相册">
        <el-upload
          action="#"
          list-type="picture-card"
          :file-list="form.images.map((url, i) => ({ url, uid: i }))"
          :http-request="uploadGallery"
          :on-remove="handleRemoveGallery"
        >
          <i class="el-icon-plus"></i>
        </el-upload>
      </el-form-item>
      <el-form-item label="描述">
        <quill-editor v-model="form.description" style="height: 300px; margin-bottom: 50px;" />
      </el-form-item>
      <el-form-item label="上架"><el-switch v-model="form.status" :active-value="1" :inactive-value="0" /></el-form-item>

      <el-divider>规格维度</el-divider>
      <div v-for="(spec, idx) in form.specs" :key="idx" style="display:flex;gap:8px;margin-bottom:8px">
        <el-input v-model="spec.specName" placeholder="规格名，如颜色" style="width:120px" />
        <el-input v-model="spec.specValues" placeholder="规格值，逗号分隔，如红,蓝" style="flex:1" />
        <el-button type="danger" icon="el-icon-delete" circle @click="form.specs.splice(idx,1)" />
      </div>
      <el-button size="small" @click="form.specs.push({specName:'',specValues:''})">添加规格</el-button>
      <el-button size="small" type="primary" @click="generateSkus">生成SKU</el-button>

      <el-divider>SKU列表</el-divider>
      <div style="margin-bottom: 16px; display: flex; gap: 16px; align-items: center;" v-if="form.skus && form.skus.length > 0">
        <span style="font-size: 14px; color: #606266;">批量设置：</span>
        <el-input-number v-model="batchPrice" :min="0" :precision="2" size="small" placeholder="价格" controls-position="right" style="width: 130px;"></el-input-number>
        <el-input-number v-model="batchStock" :min="0" size="small" placeholder="库存" controls-position="right" style="width: 130px;"></el-input-number>
        <el-button type="primary" size="small" plain @click="applyBatchSet">应用到所有SKU</el-button>
      </div>
      <el-table :data="form.skus" border size="small">
        <el-table-column label="规格">
          <template slot-scope="{ row }">{{ formatSpec(row.specJson) }}</template>
        </el-table-column>
        <el-table-column label="价格" width="120">
          <template slot-scope="{ row }"><el-input-number v-model="row.price" :min="0" :precision="2" size="small" /></template>
        </el-table-column>
        <el-table-column label="库存" width="100">
          <template slot-scope="{ row }"><el-input-number v-model="row.stock" :min="0" size="small" /></template>
        </el-table-column>
        <el-table-column label="SKU编码" width="140">
          <template slot-scope="{ row }"><el-input v-model="row.skuCode" size="small" /></template>
        </el-table-column>
      </el-table>

      <div style="margin-top:24px">
        <el-button type="primary" :loading="saving" @click="submit">保存</el-button>
        <el-button @click="$router.back()">返回</el-button>
      </div>
    </el-form>
  </el-card>
</template>

<script>
import { quillEditor } from 'vue-quill-editor'
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'

import { getCategoryTree } from '@/api/category'
import { getProductDetail, createProduct, updateProduct } from '@/api/product'
import { uploadFile } from '@/api/file'

export default {
  name: 'ProductEdit',
  components: {
    quillEditor
  },
  data() {
    return {
      saving: false,
      batchPrice: undefined,
      batchStock: undefined,
      categoryTree: [],
      form: {
        name: '', categoryId: null, description: '', mainImage: '', status: 1,
        specs: [{ specName: '颜色', specValues: '红,蓝' }, { specName: '尺码', specValues: 'M,L' }],
        skus: [], images: []
      },
      rules: {
        name: [{ required: true, message: '请输入商品名称', trigger: 'blur' }],
        categoryId: [{ required: true, message: '请选择分类', trigger: 'change' }]
      }
    }
  },
  computed: {
    isEdit() { return !!this.$route.params.id }
  },
  async created() {
    const catRes = await getCategoryTree()
    this.categoryTree = this.processCategoryTree(catRes.data)
    if (this.isEdit) {
      const res = await getProductDetail(this.$route.params.id)
      const d = res.data
      this.form = {
        name: d.spu.name, categoryId: d.spu.categoryId, description: d.spu.description,
        mainImage: d.spu.mainImage, status: d.spu.status,
        specs: d.specs.map(s => ({ specName: s.specName, specValues: s.specValues })),
        skus: d.skus.map(s => ({ specJson: s.specJson, price: s.price, stock: s.stock, image: s.image, skuCode: s.skuCode })),
        images: d.images.map(i => i.imageUrl)
      }
    } else {
      this.generateSkus()
    }
  },
  methods: {
    applyBatchSet() {
      if (!this.form.skus || !this.form.skus.length) return;
      const price = this.batchPrice !== undefined ? this.batchPrice : null;
      const stock = this.batchStock !== undefined ? this.batchStock : null;

      if (price === null && stock === null) {
        this.$message.warning('请先输入要批量设置的价格或库存');
        return;
      }

      this.form.skus.forEach(sku => {
        if (price !== null) sku.price = price;
        if (stock !== null) sku.stock = stock;
      });
      this.$message.success('批量设置成功');
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
    processCategoryTree(list) {
      if (!list || !list.length) return undefined
      return list.map(item => ({
        ...item,
        children: (item.children && item.children.length > 0) ? this.processCategoryTree(item.children) : undefined
      }))
    },
    generateSkus() {
      const specs = this.form.specs.filter(s => s.specName && s.specValues)
      if (!specs.length) { this.$message.warning('请先填写规格维度'); return }
      const arrays = specs.map(s => s.specValues.split(',').map(v => v.trim()).filter(Boolean).map(v => ({ [s.specName]: v })))
      const combos = arrays.reduce((acc, curr) => {
        if (!acc.length) return curr.map(c => [c])
        const result = []
        acc.forEach(a => curr.forEach(c => result.push([...a, c])))
        return result
      }, [])
      this.form.skus = combos.map(combo => {
        const obj = Object.assign({}, ...combo)
        return { specJson: JSON.stringify(obj), price: 0, stock: 0, image: '', skuCode: '' }
      })
    },
    async uploadMain({ file }) {
      const res = await uploadFile(file)
      this.form.mainImage = res.data.url
    },
    async uploadGallery({ file }) {
      const res = await uploadFile(file)
      this.form.images.push(res.data.url)
    },
    handleRemoveGallery(file, fileList) {
      this.form.images = fileList.map(f => f.url || f.response?.data?.url)
    },
    submit() {
      this.$refs.form.validate(async valid => {
        if (!valid || !this.form.skus.length) return
        this.saving = true
        try {
          if (this.isEdit) await updateProduct(this.$route.params.id, this.form)
          else await createProduct(this.form)
          this.$message.success('保存成功')
          this.$router.push('/product')
        } finally { this.saving = false }
      })
    }
  }
}
</script>
