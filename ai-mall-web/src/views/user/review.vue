<template>
  <div class="review-page">
    <div class="review-tabs">
      <button
        type="button"
        :class="['tab-btn', { active: activeTab === 'pending' }]"
        @click="switchTab('pending')"
      >
        待评价
      </button>
      <button
        type="button"
        :class="['tab-btn', { active: activeTab === 'my' }]"
        @click="switchTab('my')"
      >
        我的评价
      </button>
    </div>

    <!-- 待评价 -->
    <div v-if="activeTab === 'pending'">
      <div v-if="pendingList.length" class="item-list">
        <div v-for="item in pendingList" :key="item.orderItemId" class="review-card">
          <img :src="item.image" class="card-img" alt="" @click="goProduct(item.spuId)" />
          <div class="card-info">
            <div class="card-name" @click="goProduct(item.spuId)">{{ item.spuName }}</div>
            <div class="card-spec" v-if="item.skuSpec">{{ formatSpec(item.skuSpec) }}</div>
            <div class="card-price-qty">
              <span class="price">¥{{ item.price }}</span>
              <span class="qty">x {{ item.quantity }}</span>
            </div>
            <div class="card-time" v-if="item.finishTime">完成时间: {{ formatTime(item.finishTime) }}</div>
          </div>
          <div class="card-action">
            <button class="shopify-btn shopify-btn--outline review-btn" @click="openReviewForm(item)">去评价</button>
          </div>
        </div>
      </div>
      <div v-else-if="!pendingLoading" class="empty-state">
        <van-icon name="comment-o" size="48" color="var(--color-border)" />
        <p>暂无待评价商品</p>
      </div>
      <div class="load-more" v-if="pendingList.length < pendingTotal">
        <button class="shopify-btn shopify-btn--outline" :disabled="pendingLoading" @click="loadPending()">
          {{ pendingLoading ? '加载中...' : '加载更多' }}
        </button>
      </div>
    </div>

    <!-- 我的评价 -->
    <div v-else>
      <div v-if="myList.length" class="item-list">
        <div v-for="item in myList" :key="item.id" class="review-card my-review-card">
          <img :src="item.spuImage" class="card-img" alt="" @click="goProduct(item.spuId)" />
          <div class="card-info">
            <div class="card-name" @click="goProduct(item.spuId)">{{ item.spuName }}</div>
            <div class="card-spec" v-if="item.skuSpec">{{ formatSpec(item.skuSpec) }}</div>
            <div class="card-rating">
              <van-rate :value="item.rating" readonly :size="14" color="#faab0c" void-icon="star" void-color="#e8e8e8" />
              <span class="card-time">{{ formatTime(item.createTime) }}</span>
            </div>
            <div class="card-content" v-if="item.content">{{ item.content }}</div>
            <div class="card-images" v-if="item.images && item.images.length">
              <img
                v-for="(img, idx) in item.images"
                :key="idx"
                :src="img"
                class="card-thumb"
                alt=""
                @click="previewImages(item.images, idx)"
              />
            </div>
          </div>
        </div>
      </div>
      <div v-else-if="!myLoading" class="empty-state">
        <van-icon name="comment-o" size="48" color="var(--color-border)" />
        <p>您还没有发表过评价</p>
      </div>
      <div class="load-more" v-if="myList.length < myTotal">
        <button class="shopify-btn shopify-btn--outline" :disabled="myLoading" @click="loadMy()">
          {{ myLoading ? '加载中...' : '加载更多' }}
        </button>
      </div>
    </div>

    <!-- 评价表单弹窗 -->
    <van-popup
      v-model="showForm"
      :position="isMobile ? 'bottom' : 'center'"
      round
      closeable
      :style="isMobile ? { maxHeight: '85%' } : { width: '480px', maxHeight: '85%', overflowY: 'auto' }"
    >
      <div class="form-wrapper" v-if="currentItem">
        <div class="form-header">评价商品</div>
        <div class="form-body">
          <div class="form-product">
            <img :src="currentItem.image" class="form-product-img" alt="" />
            <div class="form-product-info">
              <div class="form-product-name">{{ currentItem.spuName }}</div>
              <div class="form-product-spec" v-if="currentItem.skuSpec">{{ formatSpec(currentItem.skuSpec) }}</div>
            </div>
          </div>
          <div class="form-group">
            <label>评分</label>
            <van-rate v-model="form.rating" :size="24" color="#faab0c" void-icon="star" void-color="#e8e8e8" />
          </div>
          <div class="form-group">
            <label>评价内容</label>
            <textarea
              v-model="form.content"
              rows="4"
              class="custom-textarea"
              maxlength="500"
              placeholder="分享您的使用体验..."
            ></textarea>
          </div>
          <div class="form-group">
            <label>晒图（最多6张）</label>
            <van-uploader
              v-model="form.fileList"
              :max-count="6"
              :after-read="afterRead"
              :before-read="beforeRead"
            />
          </div>
          <button class="shopify-btn submit-btn" :disabled="submitting" @click="submitForm">
            {{ submitting ? '提交中...' : '提交评价' }}
          </button>
        </div>
      </div>
    </van-popup>
  </div>
</template>

<script>
import { getPendingReviews, getMyReviews, submitReview } from '@/api/review'
import { uploadFile } from '@/api/file'
import { previewImages as showImagePreview } from '@/utils/image-preview'

export default {
  name: 'UserReviewPage',
  data() {
    return {
      activeTab: 'pending',
      pendingList: [],
      pendingTotal: 0,
      pendingPageNum: 1,
      pendingLoading: false,
      myList: [],
      myTotal: 0,
      myPageNum: 1,
      myLoading: false,
      pageSize: 10,
      showForm: false,
      currentItem: null,
      submitting: false,
      form: {
        rating: 5,
        content: '',
        fileList: []
      }
    }
  },
  created() {
    this.loadPending(true)
  },
  methods: {
    formatSpec(specJsonStr) {
      if (!specJsonStr) return ''
      try {
        const obj = JSON.parse(specJsonStr)
        return Object.entries(obj).map(([k, v]) => `${k}: ${v}`).join(' | ')
      } catch (e) {
        return specJsonStr
      }
    },
    formatTime(timeStr) {
      if (!timeStr) return ''
      return String(timeStr).replace('T', ' ').slice(0, 16)
    },
    goProduct(spuId) {
      if (spuId) this.$router.push('/product/' + spuId)
    },
    previewImages(images, startPosition) {
      showImagePreview(images, startPosition)
    },
    switchTab(tab) {
      if (this.activeTab === tab) return
      this.activeTab = tab
      if (tab === 'pending') {
        this.loadPending(true)
      } else {
        this.loadMy(true)
      }
    },
    async loadPending(reset = false) {
      if (reset) {
        this.pendingPageNum = 1
        this.pendingList = []
        this.pendingTotal = 0
      }
      this.pendingLoading = true
      try {
        const res = await getPendingReviews({ pageNum: this.pendingPageNum, pageSize: this.pageSize })
        const data = res.data || {}
        this.pendingList = this.pendingList.concat(data.list || [])
        this.pendingTotal = data.total || 0
        this.pendingPageNum++
      } catch (e) {
        // error handled globally
      } finally {
        this.pendingLoading = false
      }
    },
    async loadMy(reset = false) {
      if (reset) {
        this.myPageNum = 1
        this.myList = []
        this.myTotal = 0
      }
      this.myLoading = true
      try {
        const res = await getMyReviews({ pageNum: this.myPageNum, pageSize: this.pageSize })
        const data = res.data || {}
        this.myList = this.myList.concat(data.list || [])
        this.myTotal = data.total || 0
        this.myPageNum++
      } catch (e) {
        // error handled globally
      } finally {
        this.myLoading = false
      }
    },
    openReviewForm(item) {
      this.currentItem = item
      this.form = { rating: 5, content: '', fileList: [] }
      this.showForm = true
    },
    beforeRead(file) {
      const files = Array.isArray(file) ? file : [file]
      for (const f of files) {
        if (!f.type || !f.type.startsWith('image/')) {
          this.$toast('仅支持上传图片')
          return false
        }
        if (f.size > 5 * 1024 * 1024) {
          this.$toast('图片大小不能超过5MB')
          return false
        }
      }
      return true
    },
    async afterRead(file) {
      const files = Array.isArray(file) ? file : [file]
      for (const f of files) {
        f.status = 'uploading'
        f.message = '上传中...'
        try {
          const res = await uploadFile(f.file)
          f.url = res.data && res.data.url
          f.status = 'done'
          f.message = ''
        } catch (e) {
          f.status = 'failed'
          f.message = '上传失败'
        }
      }
    },
    async submitForm() {
      if (!this.form.rating) {
        this.$toast('请选择评分')
        return
      }
      if (!this.form.content.trim()) {
        this.$toast('请填写评价内容')
        return
      }
      if (this.form.fileList.some(f => f.status === 'uploading')) {
        this.$toast('图片上传中，请稍候')
        return
      }
      this.submitting = true
      try {
        const images = this.form.fileList
          .filter(f => f.status === 'done' && f.url)
          .map(f => f.url)
        await submitReview({
          orderItemId: this.currentItem.orderItemId,
          rating: this.form.rating,
          content: this.form.content.trim(),
          images
        })
        this.$toast.success('评价成功')
        this.showForm = false
        this.loadPending(true)
      } catch (e) {
        // error handled globally
      } finally {
        this.submitting = false
      }
    }
  }
}
</script>

<style scoped>
.review-page {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  min-height: 400px;
}

.review-tabs {
  display: flex;
  border-bottom: 1px solid var(--color-border);
}

.tab-btn {
  flex: 0 0 auto;
  padding: 16px 24px;
  background: none;
  border: none;
  border-bottom: 2px solid transparent;
  font-size: 14px;
  font-weight: 500;
  color: var(--color-text-muted);
  cursor: pointer;
  transition: all 0.2s;
}

.tab-btn.active {
  color: var(--color-primary);
  border-bottom-color: var(--color-primary);
  font-weight: 600;
}

.item-list {
  padding: 0 24px;
}

.review-card {
  display: flex;
  gap: 16px;
  padding: 20px 0;
  border-bottom: 1px solid var(--color-surface);
}

.review-card:last-child {
  border-bottom: none;
}

.card-img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: var(--radius-sm);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  cursor: pointer;
  flex-shrink: 0;
}

.card-info {
  flex: 1;
  min-width: 0;
}

.card-name {
  font-size: 14px;
  font-weight: 500;
  margin-bottom: 4px;
  cursor: pointer;
}

.card-name:hover {
  text-decoration: underline;
}

.card-spec {
  font-size: 12px;
  color: var(--color-text-muted);
  margin-bottom: 8px;
}

.card-price-qty {
  font-size: 13px;
}

.card-price-qty .qty {
  color: var(--color-text-muted);
  margin-left: 8px;
}

.card-time {
  font-size: 12px;
  color: var(--color-text-muted);
  margin-top: 8px;
}

.card-rating {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 8px;
}

.card-rating .card-time {
  margin-top: 0;
}

.card-content {
  font-size: 14px;
  line-height: 1.6;
  white-space: pre-wrap;
}

.card-images {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  margin-top: 8px;
}

.card-thumb {
  width: 64px;
  height: 64px;
  object-fit: cover;
  border-radius: var(--radius-sm);
  border: 1px solid var(--color-border);
  cursor: pointer;
}

.card-action {
  display: flex;
  align-items: center;
  flex-shrink: 0;
}

.review-btn {
  padding: 8px 16px;
  font-size: 13px;
}

.empty-state {
  text-align: center;
  padding: 64px 0;
  color: var(--color-text-muted);
  font-size: 14px;
}

.empty-state p {
  margin-top: 16px;
}

.load-more {
  text-align: center;
  padding: 24px;
}

/* Form Popup */
.form-wrapper {
  display: flex;
  flex-direction: column;
}

.form-header {
  text-align: center;
  font-size: 18px;
  font-weight: 500;
  padding: 20px;
  border-bottom: 1px solid var(--color-border);
}

.form-body {
  padding: 24px;
}

.form-product {
  display: flex;
  gap: 12px;
  margin-bottom: 20px;
  padding-bottom: 16px;
  border-bottom: 1px solid var(--color-surface);
}

.form-product-img {
  width: 56px;
  height: 56px;
  object-fit: cover;
  border-radius: var(--radius-sm);
  border: 1px solid var(--color-border);
}

.form-product-name {
  font-size: 14px;
  font-weight: 500;
  margin-bottom: 4px;
}

.form-product-spec {
  font-size: 12px;
  color: var(--color-text-muted);
}

.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  font-size: 13px;
  font-weight: 500;
  margin-bottom: 8px;
}

.custom-textarea {
  width: 100%;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  padding: 12px;
  font-size: 14px;
  outline: none;
  resize: none;
  box-sizing: border-box;
  font-family: inherit;
}

.custom-textarea:focus {
  border-color: var(--color-primary);
}

.submit-btn {
  width: 100%;
}

@media (max-width: 767px) {
  .review-page {
    border: none;
    border-radius: 0;
  }
  .item-list {
    padding: 0 16px;
  }
  .card-img {
    width: 64px;
    height: 64px;
  }
  .review-card {
    flex-wrap: wrap;
  }
  .card-action {
    width: 100%;
    justify-content: flex-end;
  }
}
</style>
