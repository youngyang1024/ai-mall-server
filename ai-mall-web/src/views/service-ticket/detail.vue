<template>
  <div class="ticket-detail-page" v-if="detail">
    <div class="header-row">
      <div>
        <h1 class="page-title">工单详情</h1>
        <div class="ticket-meta">工单号：{{ detail.ticketNo }}</div>
      </div>
      <div class="header-actions">
        <span class="status-badge" :class="'status-' + detail.status">{{ detail.statusDesc }}</span>
        <button v-if="detail.status !== 2" class="shopify-btn shopify-btn--outline" @click="completeTicket">标记完成</button>
      </div>
    </div>

    <div class="summary-card">
      <div class="summary-grid">
        <div><span>服务分类</span><strong>{{ detail.categoryName }}</strong></div>
        <div><span>问题类型</span><strong>{{ detail.issueName }}</strong></div>
        <div v-if="detail.orderNo"><span>订单号</span><strong>{{ detail.orderNo }}</strong></div>
        <div><span>联系方式</span><strong>{{ detail.contactEmail }} / {{ displayPhone }}</strong></div>
      </div>
    </div>

    <div class="conversation-card">
      <h2 class="card-title">沟通记录</h2>
      <div v-for="reply in detail.replies" :key="reply.id" class="reply-item" :class="{ admin: reply.userType === 2 }">
        <div class="reply-meta">
          <span class="reply-author">{{ reply.userTypeDesc }}</span>
          <span class="reply-time">{{ formatTime(reply.createTime) }}</span>
        </div>
        <div class="reply-content">{{ reply.content }}</div>
        <div v-if="reply.attachments && reply.attachments.length" class="attachment-list">
          <div v-if="getImageAttachments(reply.attachments).length" class="attachment-images">
            <img
              v-for="file in getImageAttachments(reply.attachments)"
              :key="file.id"
              :src="file.fileUrl"
              :alt="file.fileName || '图片附件'"
              class="attachment-image"
              @click="openPreview(getImageAttachments(reply.attachments), file.fileUrl)"
            />
          </div>
          <a
            v-for="file in getOtherAttachments(reply.attachments)"
            :key="file.id"
            :href="file.fileUrl"
            target="_blank"
            rel="noopener"
            class="attachment-link"
          >
            {{ file.fileName || file.fileUrl }}
          </a>
        </div>
      </div>
    </div>

    <div class="reply-form-card" v-if="detail.status !== 2">
      <h2 class="card-title">继续跟进</h2>
      <textarea v-model.trim="replyContent" class="reply-textarea" maxlength="1500" placeholder="请输入补充说明"></textarea>
      <div class="count-text">{{ replyContent.length }}/1500</div>

      <div class="upload-box">
        <input ref="replyInput" type="file" multiple class="file-input" accept=".jpg,.jpeg,.gif,.png,.bmp,.mp4,.rmvb" @change="handleFileChange" />
        <button type="button" class="upload-trigger" @click="$refs.replyInput.click()">上传附件</button>
        <div v-if="replyAttachments.length" class="attachment-pending">
          <div v-for="item in replyAttachments" :key="item.url" class="pending-item">
            <span>{{ item.name }}</span>
            <button type="button" @click="removeAttachment(item.url)">删除</button>
          </div>
        </div>
      </div>

      <button class="shopify-btn submit-btn" @click="submitReply">提交回复</button>
    </div>

    <div v-if="previewVisible" class="image-preview-mask" @click="closePreview">
      <button type="button" class="image-preview-close" @click.stop="closePreview">×</button>
      <button
        v-if="previewUrls.length > 1"
        type="button"
        class="image-preview-nav image-preview-nav--prev"
        @click.stop="switchPreview(-1)"
      >‹</button>
      <button
        v-if="previewUrls.length > 1"
        type="button"
        class="image-preview-nav image-preview-nav--next"
        @click.stop="switchPreview(1)"
      >›</button>

      <div class="image-preview-stage" @click.stop @wheel.prevent="handlePreviewWheel">
        <div class="image-preview-canvas">
          <img
            :src="previewUrls[previewIndex]"
            alt="预览图片"
            class="image-preview-img"
            :style="previewImageStyle"
            @load="handlePreviewImageLoad"
          />
        </div>
      </div>

      <div class="image-preview-footer" @click.stop>
        <div v-if="previewUrls.length > 1" class="image-preview-index">
          {{ previewIndex + 1 }} / {{ previewUrls.length }}
        </div>
        <div class="image-preview-toolbar">
          <button type="button" class="image-preview-zoom-btn" :disabled="previewScale <= minPreviewScale" @click="zoomPreview(-0.25)">－</button>
          <span class="image-preview-zoom-text">{{ Math.round(previewScale * 100) }}%</span>
          <button type="button" class="image-preview-zoom-btn" :disabled="previewScale >= maxPreviewScale" @click="zoomPreview(0.25)">＋</button>
          <button type="button" class="image-preview-zoom-reset" @click="resetPreviewScale">重置</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { completeServiceTicket, getServiceTicketDetail, replyServiceTicket, uploadServiceTicketFile } from '@/api/service-ticket'

export default {
  name: 'ServiceTicketDetailPage',
  data() {
    return {
      detail: null,
      replyContent: '',
      replyAttachments: [],
      previewVisible: false,
      previewUrls: [],
      previewIndex: 0,
      previewScale: 1,
      minPreviewScale: 0.5,
      maxPreviewScale: 4,
      previewNaturalWidth: 0,
      previewNaturalHeight: 0
    }
  },
  computed: {
    displayPhone() {
      if (!this.detail) return ''
      return [this.detail.contactAreaCode, this.detail.contactPhone].filter(Boolean).join(' ')
    },
    previewFitWidth() {
      if (!this.previewNaturalWidth || !this.previewNaturalHeight) return 0
      const maxWidth = Math.min(window.innerWidth * 0.92, 1200)
      const maxHeight = Math.min(window.innerHeight * 0.72, 780)
      const widthRatio = maxWidth / this.previewNaturalWidth
      const heightRatio = maxHeight / this.previewNaturalHeight
      const ratio = Math.min(widthRatio, heightRatio, 1)
      return Math.max(1, Math.round(this.previewNaturalWidth * ratio))
    },
    previewImageStyle() {
      if (!this.previewFitWidth) {
        return {
          maxWidth: '92vw',
          maxHeight: '72vh',
          width: 'auto',
          height: 'auto'
        }
      }
      return {
        width: `${Math.round(this.previewFitWidth * this.previewScale)}px`,
        height: 'auto',
        maxWidth: 'none',
        maxHeight: 'none'
      }
    }
  },
  async created() {
    await this.loadData()
  },
  methods: {
    async loadData() {
      const res = await getServiceTicketDetail(this.$route.params.ticketNo)
      this.detail = res.data
    },
    formatTime(value) {
      return value ? value.replace('T', ' ') : ''
    },
    isImageFile(file) {
      const value = (file.fileType || file.fileName || file.fileUrl || '').toLowerCase()
      return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].some(ext => value.includes(ext))
    },
    getImageAttachments(files = []) {
      return files.filter(file => this.isImageFile(file))
    },
    getOtherAttachments(files = []) {
      return files.filter(file => !this.isImageFile(file))
    },
    openPreview(files, currentUrl) {
      this.previewUrls = files.map(file => file.fileUrl)
      const index = this.previewUrls.findIndex(url => url === currentUrl)
      this.previewIndex = index < 0 ? 0 : index
      this.previewScale = 1
      this.previewNaturalWidth = 0
      this.previewNaturalHeight = 0
      this.previewVisible = true
    },
    closePreview() {
      this.previewVisible = false
      this.previewUrls = []
      this.previewIndex = 0
      this.previewScale = 1
      this.previewNaturalWidth = 0
      this.previewNaturalHeight = 0
    },
    switchPreview(step) {
      if (!this.previewUrls.length) return
      const next = (this.previewIndex + step + this.previewUrls.length) % this.previewUrls.length
      this.previewIndex = next
      this.previewScale = 1
      this.previewNaturalWidth = 0
      this.previewNaturalHeight = 0
    },
    handlePreviewImageLoad(event) {
      const img = event.target
      this.previewNaturalWidth = img.naturalWidth || 0
      this.previewNaturalHeight = img.naturalHeight || 0
    },
    zoomPreview(step) {
      const next = Math.round((this.previewScale + step) * 100) / 100
      this.previewScale = Math.min(this.maxPreviewScale, Math.max(this.minPreviewScale, next))
    },
    resetPreviewScale() {
      this.previewScale = 1
    },
    handlePreviewWheel(event) {
      const step = event.deltaY > 0 ? -0.1 : 0.1
      this.zoomPreview(step)
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
          this.replyAttachments.push({ name: file.name, url: res.data })
        }
      } catch (e) {
        this.$toast(e.message || '上传失败')
      } finally {
        event.target.value = ''
      }
    },
    removeAttachment(url) {
      this.replyAttachments = this.replyAttachments.filter(item => item.url !== url)
    },
    async submitReply() {
      if (!this.replyContent) {
        this.$toast('请输入回复内容')
        return
      }
      await replyServiceTicket(this.detail.ticketNo, {
        content: this.replyContent,
        attachmentUrls: this.replyAttachments.map(item => item.url)
      })
      this.$toast.success('提交成功')
      this.replyContent = ''
      this.replyAttachments = []
      await this.loadData()
    },
    async completeTicket() {
      await this.$dialog.confirm({ title: '确认将工单标记为已完成？' })
      await completeServiceTicket(this.detail.ticketNo)
      this.$toast.success('工单已完成')
      await this.loadData()
    }
  }
}
</script>

<style scoped>
.ticket-detail-page {
  max-width: 1000px;
  margin: 0 auto;
  padding: 40px 16px;
}
.header-row {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  gap: 16px;
  margin-bottom: 24px;
}
.page-title {
  margin: 0 0 6px;
  font-size: 28px;
  font-weight: 600;
}
.ticket-meta {
  color: var(--color-text-muted);
  font-size: 14px;
}
.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}
.status-badge {
  font-size: 14px;
  font-weight: 600;
}
.status-0 { color: #ff976a; }
.status-1 { color: #1989fa; }
.status-2 { color: #07c160; }
.summary-card,
.conversation-card,
.reply-form-card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 24px;
  margin-bottom: 20px;
}
.summary-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 18px 24px;
}
.summary-grid span {
  display: block;
  color: var(--color-text-muted);
  font-size: 13px;
  margin-bottom: 8px;
}
.summary-grid strong {
  font-size: 15px;
  color: var(--color-text-main);
}
.card-title {
  margin: 0 0 16px;
  font-size: 20px;
  font-weight: 600;
}
.reply-item {
  border-left: 3px solid #e6e6e6;
  padding: 14px 0 14px 16px;
}
.reply-item + .reply-item {
  border-top: 1px solid var(--color-surface);
}
.reply-item.admin {
  border-left-color: var(--color-primary);
}
.reply-meta {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 10px;
}
.reply-author {
  font-weight: 600;
}
.reply-time {
  color: var(--color-text-muted);
  font-size: 13px;
}
.reply-content {
  white-space: pre-wrap;
  line-height: 1.8;
}
.attachment-list,
.attachment-pending {
  margin-top: 12px;
  display: flex;
  flex-direction: column;
  gap: 8px;
}
.attachment-link {
  color: var(--color-primary);
  word-break: break-all;
}
.attachment-images {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}
.attachment-image {
  width: 96px;
  height: 96px;
  object-fit: cover;
  border-radius: 8px;
  border: 1px solid var(--color-border);
  cursor: pointer;
  background: #fff;
}
.reply-textarea {
  width: 100%;
  min-height: 160px;
  border: 1px solid #d8d8d8;
  padding: 14px 16px;
  box-sizing: border-box;
  font-size: 15px;
  resize: vertical;
}
.count-text {
  text-align: right;
  margin-top: 8px;
  color: var(--color-text-muted);
  font-size: 13px;
}
.file-input {
  display: none;
}
.upload-box {
  margin-top: 16px;
}
.upload-trigger {
  border: 1px solid var(--color-border);
  background: #fff;
  padding: 10px 16px;
}
.pending-item {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  font-size: 14px;
}
.pending-item button {
  border: none;
  background: none;
  color: #ee0a24;
}
.submit-btn {
  margin-top: 18px;
}
.image-preview-mask {
  position: fixed;
  inset: 0;
  z-index: 3000;
  background: rgba(0, 0, 0, 0.82);
  display: flex;
  flex-direction: column;
  box-sizing: border-box;
}
.image-preview-close {
  position: absolute;
  top: 16px;
  right: 20px;
  width: 40px;
  height: 40px;
  border: none;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.15);
  color: #fff;
  font-size: 28px;
  line-height: 1;
  cursor: pointer;
  z-index: 3;
}
.image-preview-stage {
  flex: 1;
  width: 100%;
  min-height: 0;
  overflow: auto;
  padding: 56px 48px 16px;
  box-sizing: border-box;
}
.image-preview-canvas {
  min-width: 100%;
  min-height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.image-preview-img {
  display: block;
  border-radius: 4px;
  background: transparent;
  transition: width 0.15s ease;
  user-select: none;
  -webkit-user-drag: none;
}
.image-preview-footer {
  flex-shrink: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  padding: 12px 16px 24px;
}
.image-preview-toolbar {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 12px;
  border-radius: 999px;
  background: rgba(0, 0, 0, 0.45);
  z-index: 2;
}
.image-preview-zoom-btn,
.image-preview-zoom-reset {
  min-width: 36px;
  height: 32px;
  border: 1px solid rgba(255, 255, 255, 0.35);
  border-radius: 16px;
  background: rgba(255, 255, 255, 0.12);
  color: #fff;
  font-size: 16px;
  cursor: pointer;
}
.image-preview-zoom-btn:disabled {
  opacity: 0.4;
  cursor: not-allowed;
}
.image-preview-zoom-text {
  min-width: 54px;
  text-align: center;
  color: #fff;
  font-size: 13px;
}
.image-preview-index {
  color: #fff;
  font-size: 14px;
}
.image-preview-nav {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 44px;
  height: 44px;
  border: none;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.18);
  color: #fff;
  font-size: 28px;
  line-height: 1;
  cursor: pointer;
  z-index: 3;
}
.image-preview-nav--prev {
  left: 16px;
}
.image-preview-nav--next {
  right: 16px;
}
@media (max-width: 767px) {
  .ticket-detail-page {
    padding: 16px 0 40px;
  }
  .header-row {
    flex-direction: column;
  }
  .summary-card,
  .conversation-card,
  .reply-form-card {
    border-left: none;
    border-right: none;
    border-radius: 0;
    padding: 18px 16px;
  }
  .summary-grid {
    grid-template-columns: 1fr;
  }
  .image-preview-stage {
    padding: 56px 16px 12px;
  }
  .image-preview-nav--prev {
    left: 8px;
  }
  .image-preview-nav--next {
    right: 8px;
  }
}
</style>
