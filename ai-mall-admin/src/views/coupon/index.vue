<template>
  <div>
    <el-card>
      <div slot="header" class="clearfix">
        <span>优惠券管理</span>
        <el-button style="float:right" type="primary" size="small" @click="openDialog()">新增优惠券</el-button>
      </div>
      <el-table :data="list" border>
        <el-table-column prop="name" label="券名称" />
        <el-table-column label="满减" width="140">
          <template slot-scope="{ row }">满{{ row.threshold }}减{{ row.discount }}</template>
        </el-table-column>
        <el-table-column label="库存" width="120">
          <template slot-scope="{ row }">{{ row.receivedCount }}/{{ row.totalCount }}</template>
        </el-table-column>
        <el-table-column label="有效期" min-width="200">
          <template slot-scope="{ row }">{{ row.startTime }} ~ {{ row.endTime }}</template>
        </el-table-column>
        <el-table-column label="状态" width="90">
          <template slot-scope="{ row }">{{ row.status === 1 ? '启用' : '停用' }}</template>
        </el-table-column>
        <el-table-column label="操作" width="160">
          <template slot-scope="{ row }">
            <el-button type="text" @click="openDialog(row)">编辑</el-button>
            <el-button type="text" style="color:#f56c6c" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <el-dialog :title="form.id ? '编辑优惠券' : '新增优惠券'" :visible.sync="dialogVisible" width="520px">
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="券名称" prop="name"><el-input v-model="form.name" /></el-form-item>
        <el-form-item label="满减门槛" prop="threshold"><el-input-number v-model="form.threshold" :min="0" :precision="2" /></el-form-item>
        <el-form-item label="减免金额" prop="discount"><el-input-number v-model="form.discount" :min="0" :precision="2" /></el-form-item>
        <el-form-item label="发放总量" prop="totalCount"><el-input-number v-model="form.totalCount" :min="1" /></el-form-item>
        <el-form-item label="开始时间" prop="startTime">
          <el-date-picker v-model="form.startTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" style="width:100%" />
        </el-form-item>
        <el-form-item label="结束时间" prop="endTime">
          <el-date-picker v-model="form.endTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" style="width:100%" />
        </el-form-item>
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
import { getCouponList, createCoupon, updateCoupon, deleteCoupon } from '@/api/coupon'

export default {
  name: 'CouponPage',
  data() {
    return {
      list: [],
      dialogVisible: false,
      form: { id: null, name: '', threshold: 100, discount: 10, totalCount: 100, startTime: '', endTime: '', status: 1 },
      rules: {
        name: [{ required: true, message: '请输入券名称', trigger: 'blur' }],
        threshold: [{ required: true, message: '请输入门槛', trigger: 'blur' }],
        discount: [{ required: true, message: '请输入减免金额', trigger: 'blur' }],
        totalCount: [{ required: true, message: '请输入发放总量', trigger: 'blur' }],
        startTime: [{ required: true, message: '请选择开始时间', trigger: 'change' }],
        endTime: [{ required: true, message: '请选择结束时间', trigger: 'change' }]
      }
    }
  },
  created() { this.loadData() },
  methods: {
    async loadData() {
      const res = await getCouponList()
      this.list = res.data || []
    },
    openDialog(row) {
      this.form = row ? { ...row } : { id: null, name: '', threshold: 100, discount: 10, totalCount: 100, startTime: '', endTime: '', status: 1 }
      this.dialogVisible = true
    },
    submit() {
      this.$refs.form.validate(async valid => {
        if (!valid) return
        if (this.form.id) await updateCoupon(this.form.id, this.form)
        else await createCoupon(this.form)
        this.$message.success('保存成功')
        this.dialogVisible = false
        this.loadData()
      })
    },
    async handleDelete(row) {
      await this.$confirm('确认删除该优惠券？')
      await deleteCoupon(row.id)
      this.$message.success('已删除')
      this.loadData()
    }
  }
}
</script>
