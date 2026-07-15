<template>
  <page-shell :with-tabbar-space="isMobile" :full-width="true">
    <!-- Hero Banner -->
    <section class="hero-section">
      <van-swipe v-if="banners.length" ref="heroSwipe" class="hero-swipe" :autoplay="5000" indicator-color="var(--color-primary)">
        <van-swipe-item v-for="item in banners" :key="item.id" @click="onBannerClick(item)">
          <div class="hero-slide">
            <img :src="item.imageUrl" class="hero-img" alt="" />
            <div class="hero-overlay">
              <div class="hero-content">
                <h1 class="hero-title">{{ item.title || '焕新您的生活空间' }}</h1>
                <button class="shopify-btn hero-btn">立即选购</button>
              </div>
            </div>
          </div>
        </van-swipe-item>
      </van-swipe>

      <!-- PC Custom Arrows -->
      <template v-if="banners.length > 1 && !isMobile">
        <button class="hero-arrow hero-arrow--left" @click.stop="prevSlide">
          <van-icon name="arrow-left" />
        </button>
        <button class="hero-arrow hero-arrow--right" @click.stop="nextSlide">
          <van-icon name="arrow" />
        </button>
      </template>

      <!-- Fallback Hero if no banners -->
      <div v-else-if="!banners.length" class="hero-slide">
        <img src="https://images.unsplash.com/photo-1616486338812-3dadae4b4ace?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80" class="hero-img" alt="Hero" />
        <div class="hero-overlay">
          <div class="hero-content">
            <h1 class="hero-title">焕新您的家</h1>
            <p class="hero-subtitle">精心挑选的家居好物，让生活更添诗意</p>
            <button class="shopify-btn hero-btn" @click="$router.push('/category')">探索新品</button>
          </div>
        </div>
      </div>
    </section>

    <!-- Trust Badges (Value Props) -->
    <section class="trust-badges">
      <div class="trust-inner">
        <div class="trust-item">
          <i class="van-icon van-icon-logistics"></i>
          <div class="trust-text">
            <strong>全场包邮</strong>
            <span>订单满 ¥99 即享免费配送</span>
          </div>
        </div>
        <div class="trust-item">
          <i class="van-icon van-icon-passed"></i>
          <div class="trust-text">
            <strong>品质保证</strong>
            <span>精选材质与卓越工艺</span>
          </div>
        </div>
        <div class="trust-item">
          <i class="van-icon van-icon-service-o"></i>
          <div class="trust-text">
            <strong>专业客服</strong>
            <span>提供7×24小时在线支持</span>
          </div>
        </div>
        <div class="trust-item">
          <i class="van-icon van-icon-cash-back-record"></i>
          <div class="trust-text">
            <strong>无忧退换</strong>
            <span>30天内享受无理由退换货</span>
          </div>
        </div>
      </div>
    </section>

    <!-- Main Content Container -->
    <div class="home-main">
      <!-- Categories Grid -->
      <section class="home-departments">
        <div class="section-head">
          <h2 class="section-title">
            灵感分类
            <span class="section-subtitle">INSPIRATION CATEGORIES</span>
          </h2>
          <router-link to="/category" class="section-link">查看全部 <span>→</span></router-link>
        </div>
        <div :class="['dept-grid', isMobile ? 'dept-grid--mobile' : 'dept-grid--pc']">
          <div
            v-for="(cat, idx) in categories"
            :key="cat.id"
            class="dept-card"
            @click="goList(cat.id)"
          >
            <!-- Using unsplash placeholders for category images if none provided -->
            <div class="dept-card__img-wrap">
              <img :src="getCatImage(cat.name, idx)" class="dept-card__img" alt="" />
            </div>
            <div class="dept-card__name">{{ cat.name }}</div>
          </div>
        </div>
      </section>

      <!-- Best Sellers -->
      <div class="home-recommend">
        <product-recommend-section
          title="畅销单品"
          subtitle="Top Picks for You"
          :products="hotProducts"
          :show-rank="true"
          :horizontal="false"
        />
      </div>

      <!-- Trending Search -->
      <section v-if="hotSearches.length" class="trending-search">
        <div class="section-head">
          <h2 class="section-title">
            热门搜索 
            <span class="section-subtitle">TRENDING SEARCH</span>
          </h2>
        </div>
        <div class="trending-grid">
          <button 
            v-for="item in hotSearches" 
            :key="item.id" 
            class="trending-item"
            @click="onSearchKeyword(item.keyword)"
          >
            <span v-if="item.isHot" class="hot-icon">🔥</span>
            {{ item.keyword }}
          </button>
        </div>
      </section>
    </div>
  </page-shell>
</template>

<script>
import { getCategoryTree, getHotRecommend, getHotSearchList } from '@/api/product'
import { getBannerList } from '@/api/banner'
import ProductRecommendSection from '@/components/ProductRecommendSection.vue'

export default {
  name: 'Home',
  components: { ProductRecommendSection },
  data() {
    return {
      keyword: '',
      categories: [],
      hotProducts: [],
      banners: [],
      hotSearches: [],
      placeholderImages: [
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1505693314120-0d443867891c?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1524758631624-e2822e304c36?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1540932239986-30128078f3c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80',
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80'
      ]
    }
  },
  async created() {
    const [catRes, hotRes, bannerRes, searchRes] = await Promise.all([
      getCategoryTree(),
      getHotRecommend(this.isMobile ? 4 : 8),
      getBannerList().catch(() => ({ data: [] })),
      getHotSearchList().catch(() => ({ data: [] }))
    ])
    this.categories = (catRes.data || []).slice(0, this.isMobile ? 4 : 8)
    this.hotProducts = hotRes.data || []
    this.banners = bannerRes.data || []
    this.hotSearches = searchRes.data || []
  },
  methods: {
    onSearchKeyword(kw) {
      this.$router.push({ path: '/product', query: { keyword: kw } })
    },
    prevSlide() {
      if (this.$refs.heroSwipe) {
        this.$refs.heroSwipe.prev()
      }
    },
    nextSlide() {
      if (this.$refs.heroSwipe) {
        this.$refs.heroSwipe.next()
      }
    },
    getCatImage(name, idx) {
      return this.placeholderImages[idx % this.placeholderImages.length]
    },
    onBannerClick(item) {
      if (item.linkUrl) {
        if (item.linkUrl.startsWith('http')) window.location.href = item.linkUrl
        else this.$router.push(item.linkUrl)
      } else {
        this.$router.push('/category')
      }
    },
    goList(categoryId) {
      this.$router.push({ path: '/product', query: { categoryId } })
    }
  }
}
</script>

<style scoped>
.hero-section {
  width: 100%;
  position: relative;
  background: #f0f0f0;
}

.hero-swipe {
  height: 600px;
}

.hero-slide {
  position: relative;
  width: 100%;
  height: 100%;
}

.hero-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.hero-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
}

.hero-content {
  color: #fff;
  padding: 0 24px;
  max-width: 800px;
}

.hero-title {
  font-size: 48px;
  font-weight: 700;
  margin-bottom: 16px;
  letter-spacing: 1px;
}

.hero-subtitle {
  font-size: 18px;
  margin-bottom: 32px;
  opacity: 0.9;
}

.hero-btn {
  padding: 14px 36px;
  font-size: 16px;
  background: #fff;
  color: var(--color-primary);
  border-color: #fff;
}

.hero-btn:hover {
  background: var(--color-primary);
  color: #fff;
  border-color: var(--color-primary);
}

.hero-arrow {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 48px;
  height: 48px;
  background: rgba(255, 255, 255, 0.9);
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 20px;
  color: #1a1a1a;
  z-index: 10;
  transition: all 0.3s ease;
  opacity: 0; /* hidden by default, shown on hover */
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.hero-section:hover .hero-arrow {
  opacity: 1;
}

.hero-arrow:hover {
  background: #fff;
  color: var(--color-primary);
  transform: translateY(-50%) scale(1.05);
}

.hero-arrow--left {
  left: 24px;
}

.hero-arrow--right {
  right: 24px;
}

.trust-badges {
  background: var(--color-surface);
  border-bottom: 1px solid var(--color-border);
  padding: 32px 24px;
}

.trust-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
}

.trust-item {
  display: flex;
  align-items: center;
  gap: 16px;
}

.trust-item i {
  font-size: 32px;
  color: var(--color-primary);
}

.trust-text {
  display: flex;
  flex-direction: column;
  gap: 4px;
}

.trust-text strong {
  font-size: 14px;
  font-weight: 600;
}

.trust-text span {
  font-size: 12px;
  color: var(--color-text-muted);
}

.home-main {
  max-width: 1200px;
  margin: 0 auto;
  padding: 60px 24px;
}

.trending-search {
  margin-top: 80px;
}

.trending-grid {
  display: grid;
  grid-template-columns: repeat(5, 1fr);
  gap: 16px;
}

.trending-item {
  background: var(--color-surface);
  border: 1px solid transparent;
  padding: 16px 20px;
  border-radius: 2px;
  font-size: 14px;
  color: var(--color-text-main);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.2s ease;
}

.trending-item:hover {
  background: #f0f0f0;
}

.hot-icon {
  font-size: 16px;
}

.home-departments {
  margin-bottom: 80px;
}

.section-head {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  margin-bottom: 32px;
}

.section-title {
  font-size: 28px;
  margin: 0;
  display: flex;
  align-items: baseline;
  gap: 12px;
}

.section-subtitle {
  font-size: 14px;
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-weight: normal;
}

.section-link {
  font-size: 14px;
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  display: flex;
  align-items: center;
  gap: 4px;
}

.section-link:hover {
  color: var(--color-primary);
}

.dept-grid {
  display: grid;
  gap: 24px;
}

.dept-grid--pc {
  grid-template-columns: repeat(4, 1fr);
}

.dept-grid--mobile {
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

.dept-card {
  cursor: pointer;
  group: relative;
}

.dept-card__img-wrap {
  width: 100%;
  aspect-ratio: 4/5;
  border-radius: var(--radius-sm);
  overflow: hidden;
  margin-bottom: 16px;
  background: var(--color-surface);
}

.dept-card__img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.5s ease;
}

.dept-card:hover .dept-card__img {
  transform: scale(1.05);
}

.dept-card__name {
  font-size: 16px;
  font-weight: 600;
  text-align: center;
  transition: color 0.2s;
}

.dept-card:hover .dept-card__name {
  color: var(--color-accent);
}

@media (max-width: 767px) {
  .hero-swipe {
    height: 480px;
  }
  .hero-title {
    font-size: 32px;
  }
  .hero-subtitle {
    font-size: 15px;
  }
  .trust-inner {
    grid-template-columns: 1fr;
    gap: 20px;
  }
  .home-main {
    padding: 40px 16px;
  }
  .section-title {
    font-size: 24px;
  }
  .trending-grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
  }
  .trending-item {
    padding: 12px 16px;
    font-size: 13px;
  }
}
</style>
