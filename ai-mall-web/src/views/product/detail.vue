<template>
  <page-shell :show-back="isMobile" :with-tabbar-space="false" :full-width="false">
    <div v-if="detail" :class="['pdp', isMobile ? 'pdp--mobile' : 'pdp--pc']">
      <!-- Breadcrumb -->
      <div class="pdp-breadcrumb">
        <router-link to="/">首页</router-link>
        <span class="separator">/</span>
        <router-link to="/category">分类</router-link>
        <span class="separator">/</span>
        <span class="current">{{ detail.spu.name }}</span>
      </div>

      <div class="pdp-main">
        <!-- Gallery Area -->
        <div class="pdp-gallery">
          <!-- Mobile: Swipe -->
          <van-swipe v-if="isMobile" :autoplay="0" indicator-color="var(--color-primary)">
            <van-swipe-item v-for="(img, idx) in swipeImages" :key="idx">
              <div class="gallery-img-wrap">
                <img :src="img" class="gallery-img" alt="" />
              </div>
            </van-swipe-item>
          </van-swipe>
          
          <!-- Desktop: Main image + Thumbnails -->
          <div v-else class="gallery-desktop">
            <div class="main-image-wrap">
              <img :src="swipeImages[activeImageIndex]" class="main-image" alt="" />
            </div>
            <div class="thumbnail-list" v-if="swipeImages.length > 1">
              <div 
                v-for="(img, idx) in swipeImages" 
                :key="idx" 
                class="thumb-wrap" 
                :class="{ active: activeImageIndex === idx }"
                @click="activeImageIndex = idx"
              >
                <img :src="img" class="thumb-img" alt="" />
              </div>
            </div>
          </div>
        </div>

        <!-- Info Area (Sticky on PC) -->
        <div class="pdp-info-wrapper">
          <div class="pdp-info">
            <h1 class="product-title">{{ detail.spu.name }}</h1>
            
            <div class="product-meta">
              <div class="price-box">
                <span class="price-current">¥{{ displayPrice }}</span>
                <span class="price-original">¥{{ (Number(displayPrice) * 1.2).toFixed(2) }}</span>
              </div>
              <div class="sales-box">
                <span v-if="detail.spu.salesCount" class="sales-count">已售 {{ detail.spu.salesCount }}</span>
              </div>
            </div>

            <!-- Specs Selector -->
            <div class="product-variants">
              <div v-for="(spec, specIndex) in detail.specs" :key="spec.specName" class="variant-group">
                <div class="variant-label">
                  {{ spec.specName }}
                  <span class="variant-selected-value">{{ getSelectedValue(specIndex) }}</span>
                </div>
                <div class="variant-options">
                  <button
                    v-for="(val, valIdx) in spec.specValues"
                    :key="val"
                    type="button"
                    :class="['variant-btn', { active: isSpecSelected(specIndex, valIdx) }]"
                    @click="selectSpec(specIndex, valIdx)"
                  >
                    {{ val }}
                  </button>
                </div>
              </div>
            </div>

            <!-- Quantity & Actions -->
            <div class="product-form">
              <div class="qty-wrapper">
                <span class="qty-label">数量</span>
                <div class="qty-selector">
                  <button class="qty-btn" @click="quantity > 1 && quantity--">−</button>
                  <input type="number" v-model.number="quantity" class="qty-input" min="1" :max="currentStock || 1" />
                  <button class="qty-btn" @click="quantity < (currentStock || 1) && quantity++">+</button>
                </div>
                <span class="stock-status" :class="{ low: currentStock < 10 }">
                  {{ currentStock > 0 ? `库存 ${currentStock} 件` : '已售罄' }}
                </span>
              </div>

              <div class="action-group">
                <button 
                  class="shopify-btn action-btn btn-cart" 
                  :disabled="!currentSku || currentStock <= 0"
                  @click="handleAddCart"
                >
                  加入购物车
                </button>
                <button 
                  class="shopify-btn shopify-btn--outline action-btn btn-buy" 
                  :disabled="!currentSku || currentStock <= 0"
                  @click="handleBuy"
                >
                  立即购买
                </button>
              </div>
            </div>

            <!-- Accordions for Details -->
            <div class="product-accordions">
              <div class="accordion" :class="{ open: openAccordion === 'shipping' }">
                <div class="accordion-header" @click="toggleAccordion('shipping')">
                  <span>配送与退换</span>
                  <i class="van-icon" :class="openAccordion === 'shipping' ? 'van-icon-arrow-up' : 'van-icon-arrow-down'"></i>
                </div>
                <div class="accordion-content" v-show="openAccordion === 'shipping'">
                  <div class="desc-text">
                    <p>订单满 ¥99 享受免费配送。</p>
                    <p>支持30天无理由退换货（定制商品除外）。退款将在收到退货后的3-5个工作日内原路返回。</p>
                  </div>
                </div>
              </div>
            </div>
            
            <!-- Trust block -->
            <div class="safe-checkout">
              <span>保障安全支付</span>
              <div class="payment-icons">
                <i class="iconfont icon-alipay"></i>
                <i class="iconfont icon-wechat-pay"></i>
                <i class="iconfont icon-visa"></i>
              </div>
            </div>
            
          </div>
        </div>
      </div>

      <!-- Product Description (Rich Text) -->
      <div class="pdp-description-section" v-if="detail.spu.description">
        <h2 class="desc-title">商品详情</h2>
        <div class="rich-text-content" v-html="detail.spu.description"></div>
      </div>

      <!-- Recommend Section -->
      <div class="pdp-recommend">
        <product-recommend-section
          v-if="recommendProducts.length"
          title="为您推荐"
          subtitle="You May Also Like"
          :products="recommendProducts"
          :horizontal="false"
        />
      </div>
    </div>

    <!-- Mobile Bottom Fixed Action -->
    <div v-if="isMobile && detail" class="mobile-action-bar">
      <div class="mobile-action-icon" @click="goCart">
        <van-icon name="shopping-cart-o" size="20" />
        <span>购物车</span>
      </div>
      <button class="shopify-btn btn-cart-mobile" :disabled="!currentSku || currentStock <= 0" @click="handleAddCart">
        加入购物车
      </button>
      <button class="shopify-btn btn-buy-mobile" :disabled="!currentSku || currentStock <= 0" @click="handleBuy">
        立即购买
      </button>
    </div>
  </page-shell>
</template>

<script>
import { getProductDetail, getForYouRecommend } from '@/api/product'
import { addToCart } from '@/api/cart'
import ProductRecommendSection from '@/components/ProductRecommendSection.vue'

export default {
  name: 'ProductDetail',
  components: { ProductRecommendSection },
  data() {
    return {
      detail: null,
      recommendProducts: [],
      quantity: 1,
      selectedSpecs: [],
      openAccordion: 'shipping', // 'desc', 'shipping', or null
      activeImageIndex: 0
    }
  },
  computed: {
    swipeImages() {
      if (!this.detail) return []
      const imgs = (this.detail.images || []).map(i => i.imageUrl)
      return imgs.length ? imgs : [this.detail.spu.mainImage]
    },
    totalStock() {
      if (!this.detail?.skus) return 0
      return this.detail.skus.reduce((sum, s) => sum + (s.stock || 0), 0)
    },
    currentSku() {
      if (!this.detail?.skus?.length) return null
      const specs = this.detail.specs || []
      if (!specs.length) return this.detail.skus[0]

      if (this.selectedSpecs.length < specs.length) return null

      return this.detail.skus.find(sku => {
        let specObj
        try {
          specObj = JSON.parse(sku.specJson)
        } catch {
          return false
        }
        return specs.every((spec, idx) => {
          const val = spec.specValues[this.selectedSpecs[idx]]
          return specObj[spec.specName] === val
        })
      }) || null
    },
    currentStock() {
      return this.currentSku ? (this.currentSku.stock || 0) : 0
    },
    displayPrice() {
      if (this.currentSku) return Number(this.currentSku.price).toFixed(2)
      if (!this.detail?.skus?.length) return '--'
      const min = Math.min(...this.detail.skus.map(s => Number(s.price)))
      return min.toFixed(2)
    }
  },
  watch: {
    currentSku(sku) {
      if (sku && this.quantity > sku.stock) {
        this.quantity = Math.max(1, sku.stock)
      }
    }
  },
  async created() {
    await this.loadData()
  },
  methods: {
    async loadData() {
      const spuId = this.$route.params.id
      const [detailRes, recRes] = await Promise.all([
        getProductDetail(spuId),
        getForYouRecommend(spuId, this.isMobile ? 4 : 8).catch(() => ({ data: [] }))
      ])
      this.detail = detailRes.data
      this.recommendProducts = recRes.data || []
      this.initDefaultSpecs()
    },
    initDefaultSpecs() {
      const specs = this.detail?.specs || []
      if (!specs.length) return
      // 默认选中第一个
      this.selectedSpecs = specs.map(() => 0)
    },
    getSelectedValue(specIndex) {
      if (!this.detail || !this.detail.specs) return ''
      const spec = this.detail.specs[specIndex]
      const valIdx = this.selectedSpecs[specIndex]
      return spec.specValues[valIdx] || ''
    },
    isSpecSelected(specIndex, valIdx) {
      return this.selectedSpecs[specIndex] === valIdx
    },
    selectSpec(specIndex, valIdx) {
      this.$set(this.selectedSpecs, specIndex, valIdx)
    },
    toggleAccordion(name) {
      if (this.openAccordion === name) {
        this.openAccordion = null
      } else {
        this.openAccordion = name
      }
    },
    goCart() {
      if (!this.$store.getters.isLogin) {
        this.$router.push({ path: '/login', query: { redirect: '/cart' } })
        return
      }
      this.$router.push('/cart')
    },
    async handleAddCart() {
      if (!this.$store.getters.isLogin) {
        this.$router.push({ path: '/login', query: { redirect: this.$route.fullPath } })
        return
      }
      if (!this.currentSku) {
        this.$toast('请选择规格')
        return
      }
      if (this.currentStock <= 0) {
        this.$toast('商品已售罄')
        return
      }
      try {
        await addToCart({ skuId: this.currentSku.id, quantity: this.quantity })
        this.$toast.success('已加入购物车')
      } catch (e) {
        // error handled globally
      }
    },
    handleBuy() {
      if (!this.$store.getters.isLogin) {
        this.$router.push({ path: '/login', query: { redirect: this.$route.fullPath } })
        return
      }
      if (!this.currentSku) {
        this.$toast('请选择规格')
        return
      }
      // For real checkout: this.$router.push({ path: '/checkout', query: { skuId: this.currentSku.id, qty: this.quantity } })
      // Since we don't have direct checkout implemented, redirect to cart
      this.handleAddCart().then(() => {
        this.$router.push('/cart')
      })
    }
  }
}
</script>

<style scoped>
.pdp {
  padding-bottom: 60px;
}

.pdp-breadcrumb {
  padding: 24px 0;
  font-size: 13px;
  color: var(--color-text-muted);
}

.pdp-breadcrumb a {
  color: var(--color-text-muted);
}
.pdp-breadcrumb a:hover {
  color: var(--color-primary);
  text-decoration: underline;
}

.separator {
  margin: 0 8px;
}

.pdp-breadcrumb .current {
  color: var(--color-primary);
}

.pdp-main {
  display: flex;
  flex-direction: column;
  gap: 32px;
}

.pdp-gallery {
  width: 100%;
}

.gallery-img-wrap {
  width: 100%;
  background: var(--color-surface);
  border-radius: var(--radius-md);
  overflow: hidden;
}

.gallery-img {
  width: 100%;
  aspect-ratio: 4/5;
  object-fit: cover;
  display: block;
}

.pdp-info-wrapper {
  width: 100%;
}

.pdp-info {
  display: flex;
  flex-direction: column;
}

.product-title {
  font-size: 24px;
  font-weight: 700;
  margin-bottom: 16px;
  line-height: 1.3;
}

.product-meta {
  margin-bottom: 32px;
}

.price-box {
  display: flex;
  align-items: flex-end;
  gap: 12px;
  margin-bottom: 8px;
}

.price-current {
  font-size: 28px;
  font-weight: 700;
  color: var(--color-primary);
  line-height: 1;
}

.price-original {
  font-size: 16px;
  color: var(--color-text-muted);
  text-decoration: line-through;
  line-height: 1.2;
}

.sales-count {
  font-size: 13px;
  color: var(--color-text-muted);
}

.variant-group {
  margin-bottom: 24px;
}

.variant-label {
  font-size: 14px;
  font-weight: 600;
  margin-bottom: 12px;
}

.variant-selected-value {
  font-weight: 400;
  color: var(--color-text-muted);
  margin-left: 8px;
}

.variant-options {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.variant-btn {
  padding: 10px 20px;
  border: 1px solid var(--color-border);
  background: #fff;
  font-size: 14px;
  cursor: pointer;
  border-radius: 2px;
  transition: all 0.2s;
}

.variant-btn:hover {
  border-color: var(--color-primary);
}

.variant-btn.active {
  border-color: var(--color-primary);
  background: var(--color-primary);
  color: #fff;
}

.product-form {
  margin-bottom: 40px;
}

.qty-wrapper {
  margin-bottom: 24px;
  display: flex;
  align-items: center;
  gap: 16px;
}

.qty-label {
  font-size: 14px;
  font-weight: 600;
}

.qty-selector {
  display: flex;
  align-items: center;
  border: 1px solid var(--color-border);
  border-radius: 2px;
  height: 44px;
}

.qty-btn {
  width: 44px;
  height: 100%;
  background: transparent;
  border: none;
  font-size: 18px;
  cursor: pointer;
  color: var(--color-text-main);
}

.qty-input {
  width: 50px;
  height: 100%;
  border: none;
  border-left: 1px solid var(--color-border);
  border-right: 1px solid var(--color-border);
  text-align: center;
  font-size: 14px;
  -moz-appearance: textfield;
}

.qty-input::-webkit-outer-spin-button,
.qty-input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

.stock-status {
  font-size: 13px;
  color: #5c5c5c;
}
.stock-status.low {
  color: var(--color-accent);
}

.action-group {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.action-btn {
  width: 100%;
  height: 52px;
  font-size: 15px;
}

.product-accordions {
  border-top: 1px solid var(--color-border);
  margin-bottom: 32px;
}

.accordion {
  border-bottom: 1px solid var(--color-border);
}

.accordion-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 0;
  cursor: pointer;
  font-size: 15px;
  font-weight: 600;
}

.accordion-content {
  padding-bottom: 20px;
  font-size: 14px;
  line-height: 1.6;
  color: var(--color-text-muted);
}

.desc-text {
  white-space: pre-wrap;
}

.safe-checkout {
  background: var(--color-surface);
  padding: 16px;
  border-radius: var(--radius-sm);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 12px;
}

.safe-checkout span {
  font-size: 13px;
  font-weight: 600;
}

.payment-icons {
  display: flex;
  gap: 16px;
  font-size: 24px;
  color: var(--color-text-muted);
}

.pdp-recommend {
  margin-top: 80px;
}

.mobile-action-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 64px;
  background: #fff;
  border-top: 1px solid var(--color-border);
  display: flex;
  align-items: center;
  padding: 0 16px;
  gap: 12px;
  z-index: 100;
  padding-bottom: env(safe-area-inset-bottom);
}

.mobile-action-icon {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: var(--color-text-main);
  padding: 0 8px;
  cursor: pointer;
}

.mobile-action-icon span {
  font-size: 10px;
  margin-top: 2px;
}

.btn-cart-mobile,
.btn-buy-mobile {
  flex: 1;
  height: 40px;
  padding: 0;
  font-size: 14px;
}

.btn-cart-mobile {
  background: var(--color-surface);
  border-color: var(--color-primary);
  color: var(--color-primary);
}

.btn-buy-mobile {
  background: var(--color-primary);
  border-color: var(--color-primary);
  color: #fff;
}

/* Desktop overrides */
.pdp--pc .pdp-main {
  flex-direction: row;
  align-items: flex-start;
  gap: 60px;
}

.pdp--pc .pdp-gallery {
  flex: 1.2;
}

.main-image-wrap {
  width: 100%;
  background: var(--color-surface);
  border-radius: var(--radius-md);
  overflow: hidden;
  margin-bottom: 16px;
}

.main-image {
  width: 100%;
  aspect-ratio: 1/1;
  object-fit: cover;
  display: block;
}

.thumbnail-list {
  display: flex;
  gap: 12px;
  overflow-x: auto;
  padding-bottom: 8px;
}

.thumbnail-list::-webkit-scrollbar {
  height: 4px;
}

.thumbnail-list::-webkit-scrollbar-thumb {
  background: var(--color-border);
  border-radius: 4px;
}

.thumb-wrap {
  width: 80px;
  height: 80px;
  flex-shrink: 0;
  border-radius: var(--radius-sm);
  overflow: hidden;
  border: 2px solid transparent;
  cursor: pointer;
  transition: border-color 0.2s;
}

.thumb-wrap.active, .thumb-wrap:hover {
  border-color: var(--color-primary);
}

.thumb-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.pdp--pc .pdp-info-wrapper {
  flex: 1;
  position: sticky;
  top: 100px;
}

.pdp-description-section {
  margin-top: 60px;
  max-width: 800px;
  margin-left: auto;
  margin-right: auto;
}

.desc-title {
  font-size: 24px;
  font-weight: 600;
  text-align: center;
  margin-bottom: 32px;
}

.rich-text-content {
  line-height: 1.8;
  color: var(--color-text-main);
  font-size: 15px;
}

.rich-text-content ::v-deep img {
  max-width: 100%;
  height: auto;
  display: block;
  margin: 16px auto;
  border-radius: var(--radius-sm);
}
</style>
