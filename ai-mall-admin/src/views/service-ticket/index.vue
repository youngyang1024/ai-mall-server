<template>
  <div>
    <el-card>
      <el-form :inline="true" :model="query" size="small">
        <el-form-item label="状态">
          <el-select v-model="query.status" clearable placeholder="全部">
            <el-option label="待处理" :value="0" />
            <el-option label="处理中" :value="1" />
            <el-option label="已完成" :value="2" />
          </el-select>
        </el-form-item>
        <el-form-item label="工单号">
          <el-input v-model="query.ticketNo" clearable placeholder="请输入工单号" />
        </el-form-item>
        <el-form-item label="订单号">
          <el-input v-model="query.orderNo" clearable placeholder="请输入订单号" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">查询</el-button>
        </el-form-item>
      </el-form>

      <el-table :data="list" v-loading="loading" border>
        <el-table-column prop="ticketNo" label="工单号" min-width="170" />
        <el-table-column prop="userId" label="用户ID" width="90" />
        <el-table-column prop="categoryName" label="大类" width="120" />
        <el-table-column prop="issueName" label="问题类型" min-width="180" />
        <el-table-column prop="orderNo" label="订单号" min-width="150" />
        <el-table-column prop="statusDesc" label="状态" width="100" />
        <el-table-column prop="updateTime" label="最近更新时间" min-width="170" />
        <el-table-column label="操作" width="100" fixed="right">
          <template slot-scope="{ row }">
            <el-button type="text" @click="openDetail(row)">详情</el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-pagination
        style="margin-top:16px;text-align:right"
        :current-page="pageNum"
        :page-size="pageSize"
        :total="total"
        layout="total, prev, pager, next"
        @current-change="handlePageChange"
      />
    </el-card>

    <el-drawer :visible.sync="detailVisible" size="50%" title="工单详情" :with-header="true">
      <div v-if="detail" class="drawer-body">
        <el-descriptions :column="2" border>
          <el-descriptions-item label="工单号">{{ detail.ticketNo }}</el-descriptions-item>
          <el-descriptions-item label="状态">{{ detail.statusDesc }}</el-descriptions-item>
          <el-descriptions-item label="问题分类">{{ detail.categoryName }} / {{ detail.issueName }}</el-descriptions-item>
          <el-descriptions-item label="订单号">{{ detail.orderNo || '-' }}</el-descriptions-item>
          <el-descriptions-item label="联系人">{{ detail.contactFirstName }} {{ detail.contactLastName }}</el-descriptions-item>
          <el-descriptions-item label="联系方式">{{ detail.contactEmail }} / {{ displayPhone }}</el-descriptions-item>
        </el-descriptions>

        <div class="reply-block">
          <div class="block-title">沟通记录</div>
          <div v-for="item in detail.replies" :key="item.id" class="reply-item" :class="{ admin: item.userType === 2 }">
            <div class="reply-meta">
              <strong>{{ item.userTypeDesc }}</strong>
              <span>{{ formatTime(item.createTime) }}</span>
            </div>
            <div class="reply-content">{{ item.content }}</div>
            <div v-if="item.attachments && item.attachments.length" class="reply-attachments">
              <div v-if="getImageAttachments(item.attachments).length" class="reply-image-list">
                <el-image
                  v-for="file in getImageAttachments(item.attachments)"
                  :key="file.id"
                  :src="file.fileUrl"
                  :preview-src-list="getImageUrls(item.attachments)"
                  fit="cover"
                  class="reply-image"
                />
              </div>
              <a
                v-for="file in getOtherAttachments(item.attachments)"
                :key="file.id"
                :href="file.fileUrl"
                target="_blank"
                rel="noopener"
              >
                {{ file.fileName || file.fileUrl }}
              </a>
            </div>
          </div>
        </div>

        <div class="reply-block">
          <div class="block-title">状态处理</div>
          <div class="status-row">
            <el-select v-model="statusForm.status" style="width: 180px;">
              <el-option label="待处理" :value="0" />
              <el-option label="处理中" :value="1" />
              <el-option label="已完成" :value="2" />
            </el-select>
            <el-button type="primary" plain @click="handleUpdateStatus">更新状态</el-button>
          </div>
        </div>

        <div class="reply-block" v-if="detail.status !== 2">
          <div class="block-title">客服回复</div>
          <el-input v-model="replyForm.content" type="textarea" :rows="5" maxlength="1500" show-word-limit placeholder="请输入回复内容" />
          <div class="upload-row">
            <input ref="fileInput" class="hidden-input" type="file" multiple accept=".jpg,.jpeg,.gif,.png,.bmp,.mp4,.rmvb" @change="handleFileChange" />
            <el-button size="small" @click="$refs.fileInput.click()">上传附件</el-button>
            <div class="pending-files" v-if="replyForm.attachmentUrls.length">
              <div v-for="file in replyFiles" :key="file.url" class="pending-file">
                <span>{{ file.name }}</span>
                <el-button type="text" style="color:#f56c6c" @click="removeFile(file.url)">删除</el-button>
              </div>
            </div>
          </div>
          <el-button type="primary" style="margin-top: 12px;" @click="handleReply">提交回复</el-button>
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<script>
import {
  getServiceTicketDetail,
  getServiceTicketList,
  replyServiceTicket,
  updateServiceTicketStatus,
  uploadServiceTicketFile
} from '@/api/service-ticket'

export default {
  name: 'ServiceTicketPage',
  data() {
    return {
      query: { status: null, ticketNo: '', orderNo: '' },
      list: [],
      loading: false,
      pageNum: 1,
      pageSize: 10,
      total: 0,
      detailVisible: false,
      detail: null,
      statusForm: { status: 0 },
      replyForm: { content: '', attachmentUrls: [] },
      replyFiles: []
    }
  },
  computed: {
    displayPhone() {
      if (!this.detail) return ''
      return [this.detail.contactAreaCode, this.detail.contactPhone].filter(Boolean).join(' ')
    }
  },
  created() {
    this.loadData()
  },
  methods: {
    async loadData() {
      this.loading = true
      try {
        const res = await getServiceTicketList({
          ...this.query,
          pageNum: this.pageNum,
          pageSize: this.pageSize
        })
        this.list = res.data.list || []
        this.total = res.data.total || 0
      } finally {
        this.loading = false
      }
    },
    handleSearch() {
      this.pageNum = 1
      this.loadData()
    },
    handlePageChange(page) {
      this.pageNum = page
      this.loadData()
    },
    formatTime(value) {
      return value ? value.replace('T', ' ') : ''
    },
    isImageFile(file) {
      const value = String(file.fileType || file.fileName || file.fileUrl || '').toLowerCase()
      return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].some(ext => value.includes(ext))
    },
    getImageAttachments(files = []) {
      return files.filter(file => this.isImageFile(file))
    },
    getOtherAttachments(files = []) {
      return files.filter(file => !this.isImageFile(file))
    },
    getImageUrls(files = []) {
      return this.getImageAttachments(files).map(file => file.fileUrl)
    },
    async openDetail(row) {
      const res = await getServiceTicketDetail(row.id)
      this.detail = res.data
      this.statusForm.status = this.detail.status
      this.replyForm = { content: '', attachmentUrls: [] }
      this.replyFiles = []
      this.detailVisible = true
    },
    async handleUpdateStatus() {
      await updateServiceTicketStatus(this.detail.id, { status: this.statusForm.status })
      this.$message.success('状态已更新')
      await this.openDetail(this.detail)
      this.loadData()
    },
    validateFile(file) {
      const ext = (file.name.split('.').pop() || '').toLowerCase()
      const imageTypes = ['jpg', 'jpeg', 'gif', 'png', 'bmp']
      const videoTypes = ['mp4', 'rmvb']
      if (imageTypes.includes(ext) && file.size > 30 * 1024 * 1024) {
        throw new Error('图片大小不能超过30MB')
      }
      if (videoTypes.includes(ext) && file.size > 50 * 1024 * 1024) {
        throw new Error('视频大小不能超过50MB')
      }
      if (!imageTypes.includes(ext) && !videoTypes.includes(ext)) {
        throw new Error('附件格式不支持')
      }
    },
    async handleFileChange(event) {
      const files = Array.from(event.target.files || [])
      try {
        for (const file of files) {
          this.validateFile(file)
          const res = await uploadServiceTicketFile(file)
          this.replyForm.attachmentUrls.push(res.data)
          this.replyFiles.push({ name: file.name, url: res.data })
        }
      } catch (e) {
        this.$message.error(e.message || '上传失败')
      } finally {
        event.target.value = ''
      }
    },
    removeFile(url) {
      this.replyForm.attachmentUrls = this.replyForm.attachmentUrls.filter(item => item !== url)
      this.replyFiles = this.replyFiles.filter(item => item.url !== url)
    },
    async handleReply() {
      if (!this.replyForm.content.trim()) {
        this.$message.warning('请输入回复内容')
        return
      }
      await replyServiceTicket(this.detail.id, this.replyForm)
      this.$message.success('回复成功')
      await this.openDetail(this.detail)
      this.loadData()
    }
  }
}
</script>

<style scoped>
.drawer-body {
  padding: 0 16px 24px;
}
.reply-block {
  margin-top: 24px;
}
.block-title {
  margin-bottom: 14px;
  font-size: 16px;
  font-weight: 600;
}
.reply-item {
  border-left: 3px solid #dcdfe6;
  padding-left: 12px;
  margin-bottom: 18px;
}
.reply-item.admin {
  border-left-color: #409EFF;
}
.reply-meta {
  display: flex;
  gap: 10px;
  margin-bottom: 8px;
  color: #909399;
  font-size: 13px;
}
.reply-content {
  white-space: pre-wrap;
  line-height: 1.7;
}
.reply-attachments {
  margin-top: 10px;
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.reply-image-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 6px;
}
.reply-image {
  width: 96px;
  height: 96px;
  border-radius: 6px;
  overflow: hidden;
  border: 1px solid #dcdfe6;
}
.status-row {
  display: flex;
  align-items: center;
  gap: 12px;
}
.upload-row {
  margin-top: 12px;
}
.hidden-input {
  display: none;
}
.pending-files {
  margin-top: 10px;
}
.pending-file {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
</style>
