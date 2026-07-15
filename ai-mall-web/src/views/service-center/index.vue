<template>
  <page-shell :title="isMobile ? '服务中心' : ''" :show-back="false" :with-tabbar-space="isMobile">
    <div class="service-center-page">
      <div class="hero">
        <h1>服务中心</h1>
        <p>欢迎访问 AI Mall 自助服务页面，您可以在这里提交售后工单并持续跟进处理进度。</p>
      </div>

      <div class="category-grid">
        <button
          v-for="item in categories"
          :key="item.id"
          type="button"
          class="category-card"
          :class="{ active: activeCategoryId === item.id }"
          @click="handleCategoryChange(item.id)"
        >
          <van-icon :name="item.icon || 'service-o'" class="category-icon" />
          <span>{{ item.name }}</span>
        </button>
      </div>

      <div class="form-panel">
        <h2 class="panel-title">请详细介绍一下您的问题。</h2>

        <div class="form-group">
          <label class="required">问题分类</label>
          <select v-model="form.issueId" class="select-input">
            <option value="">请选择</option>
            <option v-for="issue in currentIssues" :key="issue.id" :value="issue.id">{{ issue.name }}</option>
          </select>
        </div>

        <div class="form-group" v-if="activeCategory && activeCategory.needOrderNo === 1">
          <label class="required">订单编号</label>
          <input v-model.trim="form.orderNo" class="text-input" placeholder="请输入订单编号" />
        </div>

        <div class="form-group">
          <label class="required">问题详情</label>
          <textarea v-model.trim="form.content" class="textarea-input" maxlength="1500" placeholder="请尽量详细描述问题，便于客服快速处理"></textarea>
          <div class="count-text">{{ form.content.length }}/1500</div>
        </div>

        <div class="form-group">
          <label>附加文件</label>
          <div class="upload-box">
            <div class="upload-tip">支持 jpg/jpeg/gif/png/bmp，不超过 30MB；支持 mp4/rmvb，不超过 50MB。</div>
            <input ref="fileInput" type="file" multiple class="file-input" accept=".jpg,.jpeg,.gif,.png,.bmp,.mp4,.rmvb" @change="handleFileChange" />
            <button type="button" class="upload-trigger" @click="$refs.fileInput.click()">+</button>
            <div class="file-list" v-if="attachments.length">
              <div v-for="item in attachments" :key="item.url" class="file-item">
                <a :href="item.url" target="_blank" rel="noopener">{{ item.name }}</a>
                <button type="button" class="remove-btn" @click="removeAttachment(item.url)">删除</button>
              </div>
            </div>
          </div>
        </div>

        <h2 class="panel-title contact-title">请留下您的联系方式，这样我们就能直接为您提供帮助。</h2>
        <div class="contact-grid">
          <div class="form-group">
            <label class="required">名字</label>
            <input v-model.trim="form.contactFirstName" class="text-input" placeholder="名字" />
          </div>
          <div class="form-group">
            <label class="required">姓氏</label>
            <input v-model.trim="form.contactLastName" class="text-input" placeholder="姓氏" />
          </div>
          <div class="form-group">
            <label class="required">邮箱</label>
            <input v-model.trim="form.contactEmail" type="email" class="text-input" placeholder="邮箱" />
          </div>
          <div class="form-group phone-group">
            <label class="required">电话</label>
            <div class="phone-row">
              <input v-model.trim="form.contactAreaCode" class="area-input" placeholder="+86" />
              <input v-model.trim="form.contactPhone" class="phone-input" placeholder="联系电话" />
            </div>
          </div>
        </div>

        <button type="button" class="submit-btn" :disabled="submitting" @click="submit">提交工单</button>
      </div>
    </div>
  </page-shell>
</template>

<script>
import { createServiceTicket, getServiceTicketOptions, uploadServiceTicketFile } from '@/api/service-ticket'
import responsiveMixin from '@/mixins/responsive'

export default {
  name: 'ServiceCenterPage',
  mixins: [responsiveMixin],
  data() {
    return {
      categories: [],
      activeCategoryId: null,
      submitting: false,
      attachments: [],
      form: {
        issueId: '',
        orderNo: '',
        content: '',
        contactFirstName: '',
        contactLastName: '',
        contactEmail: '',
        contactAreaCode: '+86',
        contactPhone: ''
      }
    }
  },
  computed: {
    activeCategory() {
      return this.categories.find(item => item.id === this.activeCategoryId) || null
    },
    currentIssues() {
      return this.activeCategory ? (this.activeCategory.issues || []) : []
    }
  },
  async created() {
    const res = await getServiceTicketOptions()
    this.categories = res.data || []
    if (this.categories.length) {
      this.activeCategoryId = this.categories[0].id
    }
  },
  methods: {
    handleCategoryChange(categoryId) {
      this.activeCategoryId = categoryId
      this.form.issueId = ''
      this.form.orderNo = ''
    },
    async handleFileChange(event) {
      if (!this.$store.getters.isLogin) {
        this.$router.push({ path: '/login', query: { redirect: this.$route.fullPath } })
        event.target.value = ''
        return
      }
      const files = Array.from(event.target.files || [])
      try {
        for (const file of files) {
          this.validateFile(file)
          const res = await uploadServiceTicketFile(file)
          this.attachments.push({
            name: file.name,
            url: res.data
          })
        }
      } catch (e) {
        this.$toast(e.message || '上传失败')
      } finally {
        event.target.value = ''
      }
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
    removeAttachment(url) {
      this.attachments = this.attachments.filter(item => item.url !== url)
    },
    validateForm() {
      const emailReg = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
      if (!this.activeCategoryId) return '请选择服务大类'
      if (!this.form.issueId) return '请选择问题分类'
      if (this.activeCategory && this.activeCategory.needOrderNo === 1 && !this.form.orderNo) return '请输入订单编号'
      if (!this.form.content) return '请输入问题详情'
      if (!this.form.contactFirstName) return '请输入名字'
      if (!this.form.contactLastName) return '请输入姓氏'
      if (!this.form.contactEmail) return '请输入邮箱'
      if (!emailReg.test(this.form.contactEmail)) return '请输入正确的邮箱格式'
      if (!this.form.contactPhone) return '请输入联系电话'
      return ''
    },
    async submit() {
      if (!this.$store.getters.isLogin) {
        this.$router.push({ path: '/login', query: { redirect: this.$route.fullPath } })
        return
      }
      const message = this.validateForm()
      if (message) {
        this.$toast(message)
        return
      }
      this.submitting = true
      try {
        const res = await createServiceTicket({
          categoryId: this.activeCategoryId,
          issueId: Number(this.form.issueId),
          orderNo: this.form.orderNo,
          content: this.form.content,
          contactFirstName: this.form.contactFirstName,
          contactLastName: this.form.contactLastName,
          contactEmail: this.form.contactEmail,
          contactAreaCode: this.form.contactAreaCode,
          contactPhone: this.form.contactPhone,
          attachmentUrls: this.attachments.map(item => item.url)
        })
        this.$toast.success('工单提交成功')
        this.$router.push(`/service-ticket/${res.data}`)
      } catch (e) {
        if (e && e.message) {
          this.$toast(e.message)
        }
      } finally {
        this.submitting = false
      }
    }
  }
}
</script>

<style scoped>
.service-center-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 24px 16px 60px;
}
.hero h1 {
  margin: 0 0 12px;
  font-size: 40px;
  font-weight: 700;
}
.hero p {
  margin: 0 0 24px;
  color: var(--color-text-muted);
  line-height: 1.7;
}
.category-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  border: 1px solid var(--color-border);
  background: #fff;
}
.category-card {
  border: none;
  border-right: 1px solid var(--color-border);
  border-bottom: 1px solid var(--color-border);
  background: #fafafa;
  padding: 28px 12px;
  display: flex;
  flex-direction: column;
  gap: 12px;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  position: relative;
}
.category-card.active {
  background: #fff;
  color: var(--color-primary);
}
.category-card.active::before {
  content: '';
  position: absolute;
  left: 0;
  top: 0;
  width: 100%;
  height: 4px;
  background: var(--color-primary);
}
.category-icon {
  font-size: 34px;
}
.form-panel {
  background: #fff;
  padding: 32px 18px 24px;
  border: 1px solid var(--color-border);
  border-top: none;
}
.panel-title {
  margin: 0 0 18px;
  font-size: 30px;
  font-weight: 700;
}
.contact-title {
  margin-top: 28px;
}
.form-group {
  margin-bottom: 22px;
}
.form-group label {
  display: block;
  margin-bottom: 8px;
  font-size: 16px;
  font-weight: 600;
}
.required::before {
  content: '*';
  color: #ee0a24;
  margin-right: 4px;
}
.text-input,
.textarea-input,
.select-input,
.area-input,
.phone-input {
  width: 100%;
  border: 1px solid #cfcfcf;
  padding: 14px 16px;
  font-size: 15px;
  background: #fff;
  box-sizing: border-box;
}
.textarea-input {
  min-height: 180px;
  resize: vertical;
}
.count-text {
  text-align: right;
  margin-top: 8px;
  color: var(--color-text-muted);
  font-size: 13px;
}
.upload-box {
  border: 1px solid #d9d9d9;
  padding: 16px;
}
.upload-tip {
  color: var(--color-text-muted);
  font-size: 13px;
  line-height: 1.6;
}
.file-input {
  display: none;
}
.upload-trigger {
  width: 92px;
  height: 92px;
  border: 1px dashed var(--color-border);
  background: var(--color-surface);
  color: var(--color-primary);
  font-size: 40px;
  margin-top: 14px;
  cursor: pointer;
}
.file-list {
  margin-top: 16px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.file-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 12px;
  font-size: 14px;
}
.file-item a {
  flex: 1;
  color: var(--color-primary);
  word-break: break-all;
}
.remove-btn {
  border: none;
  background: none;
  color: #ee0a24;
}
.contact-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 0 16px;
}
.phone-row {
  display: grid;
  grid-template-columns: 120px 1fr;
}
.phone-row input + input {
  border-left: none;
}
.submit-btn {
  width: 100%;
  height: 56px;
  border: none;
  background: var(--color-primary);
  color: #fff;
  font-size: 18px;
  font-weight: 600;
  margin-top: 10px;
  cursor: pointer;
}
.submit-btn:disabled {
  opacity: 0.65;
}
@media (max-width: 767px) {
  .hero h1 {
    font-size: 28px;
  }
  .panel-title {
    font-size: 24px;
  }
  .category-grid {
    grid-template-columns: repeat(2, 1fr);
  }
  .contact-grid {
    grid-template-columns: 1fr;
  }
}
</style>
