<template>
  <page-shell :title="pageTitle" :show-back="isMobile">
    <div v-if="keyword" class="list-head">
      <span>搜索「{{ keyword }}」</span>
    </div>

    <!-- 排序 + 价格筛选栏 -->
    <div class="sort-bar">
      <div class="sort-options">
        <button
          type="button"
          :class="['sort-btn', { active: sortBy === 'default' }]"
          @click="changeSort('default')"
        >
          综合
        </button>
        <button
          type="button"
          :class="['sort-btn', { active: sortBy === 'price_asc' || sortBy === 'price_desc' }]"
          @click="togglePriceSort"
        >
          价格
          <span class="sort-arrows">
            <i :class="['arrow', 'arrow-up', { on: sortBy === 'price_asc' }]"></i>
            <i :class="['arrow', 'arrow-down', { on: sortBy === 'price_desc' }]"></i>
          </span>
        </button>
        <button
          type="button"
          :class="['sort-btn', { active: sortBy === 'sales' }]"
          @click="changeSort('sales')"
        >
          销量
        </button>
        <button
          type="button"
          :class="['sort-btn', { active: sortBy === 'newest' }]"
          @click="changeSort('newest')"
        >
          最新
        </button>
      </div>
      <button
        type="button"
        :class="['sort-btn', 'price-filter-btn', { active: hasPriceFilter }]"
        @click="openPriceFilter"
      >
        价格{{ priceFilterText }}
        <van-icon name="filter-o" size="14" />
      </button>
    </div>

    <!-- 价格筛选弹层 -->
    <van-popup
      v-model="showPriceFilter"
      :position="isMobile ? 'bottom' : 'center'"
      round
      closeable
      :style="isMobile ? {} : { width: '360px' }"
    >
      <div class="price-filter-popup">
        <div class="price-popup-title">价格区间</div>
        <div class="price-inputs">
          <input
            v-model="priceForm.min"
            type="number"
            min="0"
            class="price-input"
            placeholder="最低价"
          />
          <span class="price-divider">—</span>
          <input
            v-model="priceForm.max"
            type="number"
            min="0"
            class="price-input"
            placeholder="最高价"
          />
        </div>
        <div class="price-popup-actions">
          <button class="shopify-btn shopify-btn--outline" type="button" @click="resetPriceFilter">重置</button>
          <button class="shopify-btn" type="button" @click="applyPriceFilter">确定</button>
        </div>
      </div>
    </van-popup>

    <van-list
      :key="listKey"
      v-model="loading"
      :finished="finished"
      finished-text="没有更多了"
      @load="loadMore"
    >
      <div :class="['product-grid', isMobile ? 'product-grid--mobile' : 'product-grid--pc']">
        <product-tile
          v-for="item in list"
          :key="item.id"
          :title="item.name"
          :price="formatPrice(item.minPrice)"
          :image="item.mainImage"
          :sales-count="item.salesCount"
          @click="$router.push(`/product/${item.id}`)"
        />
      </div>
    </van-list>

    <product-recommend-section
      v-if="recommendProducts.length"
      :title="recommendTitle"
      :products="recommendProducts"
      :horizontal="true"
    />
  </page-shell>
</template>

<script>
import { getProductList, searchProduct, getViewedAlsoRecommend, getBoughtAlsoRecommend } from '@/api/product'
import ProductRecommendSection from '@/components/ProductRecommendSection.vue'

export default {
  name: 'ProductList',
  components: { ProductRecommendSection },
  data() {
    return {
      list: [],
      loading: false,
      finished: false,
      pageNum: 1,
      pageSize: 12,
      recommendProducts: [],
      sortBy: 'default',
      minPrice: null,
      maxPrice: null,
      showPriceFilter: false,
      priceForm: { min: '', max: '' }
    }
  },
  computed: {
    categoryId() { return this.$route.query.categoryId },
    keyword() { return this.$route.query.keyword },
    pageTitle() {
      if (this.keyword) return '搜索结果'
      return '商品列表'
    },
    recommendTitle() {
      return this.keyword ? '看了又看' : '买了又买'
    },
    listKey() {
      return `${this.categoryId || ''}_${this.keyword || ''}_${this.sortBy}_${this.minPrice || ''}_${this.maxPrice || ''}`
    },
    hasPriceFilter() {
      return this.minPrice != null || this.maxPrice != null
    },
    priceFilterText() {
      if (!this.hasPriceFilter) return ''
      const min = this.minPrice != null ? `¥${this.minPrice}` : ''
      const max = this.maxPrice != null ? `¥${this.maxPrice}` : ''
      return ` ${min}-${max}`
    }
  },
  watch: {
    '$route.query': {
      immediate: true,
      handler() {
        this.resetAndLoad()
      }
    }
  },
  methods: {
    formatPrice(price) {
      if (price == null) return '0.00'
      return Number(price).toFixed(2)
    },
    resetAndLoad() {
      this.list = []
      this.pageNum = 1
      this.finished = false
      this.loading = false
      this.loadRecommend()
    },
    changeSort(sortBy) {
      if (this.sortBy === sortBy) return
      this.sortBy = sortBy
      this.resetList()
    },
    togglePriceSort() {
      this.sortBy = this.sortBy === 'price_asc' ? 'price_desc' : 'price_asc'
      this.resetList()
    },
    // 排序/价格条件变更时重置分页（listKey 变化会重建 van-list 并触发 load）
    resetList() {
      this.list = []
      this.pageNum = 1
      this.finished = false
      this.loading = false
    },
    openPriceFilter() {
      this.priceForm = {
        min: this.minPrice != null ? String(this.minPrice) : '',
        max: this.maxPrice != null ? String(this.maxPrice) : ''
      }
      this.showPriceFilter = true
    },
    applyPriceFilter() {
      let min = this.priceForm.min === '' ? null : Number(this.priceForm.min)
      let max = this.priceForm.max === '' ? null : Number(this.priceForm.max)
      if (min != null && (isNaN(min) || min < 0)) min = null
      if (max != null && (isNaN(max) || max < 0)) max = null
      if (min != null && max != null && min > max) {
        [min, max] = [max, min]
      }
      this.minPrice = min
      this.maxPrice = max
      this.showPriceFilter = false
      this.resetList()
    },
    resetPriceFilter() {
      this.priceForm = { min: '', max: '' }
      this.minPrice = null
      this.maxPrice = null
      this.showPriceFilter = false
      this.resetList()
    },
    async loadRecommend() {
      try {
        let res
        if (this.keyword) {
          res = await getViewedAlsoRecommend(this.keyword, this.isMobile ? 6 : 8)
        } else if (this.categoryId) {
          res = await getBoughtAlsoRecommend(this.categoryId, this.isMobile ? 6 : 8)
        } else {
          this.recommendProducts = []
          return
        }
        this.recommendProducts = res.data || []
      } catch (e) {
        this.recommendProducts = []
      }
    },
    async loadMore() {
      const params = { pageNum: this.pageNum, pageSize: this.pageSize, categoryId: this.categoryId }
      if (this.sortBy && this.sortBy !== 'default') params.sortBy = this.sortBy
      if (this.minPrice != null) params.minPrice = this.minPrice
      if (this.maxPrice != null) params.maxPrice = this.maxPrice
      const res = this.keyword
        ? await searchProduct({ ...params, keyword: this.keyword })
        : await getProductList(params)
      const items = res.data.list || []
      this.list = this.list.concat(items)
      this.pageNum++
      this.loading = false
      if (this.list.length >= res.data.total) this.finished = true
    }
  }
}
</script>

<style scoped>
.list-head {
  padding: 16px 0 24px;
  font-size: 16px;
  font-weight: 500;
  color: var(--color-text-main);
}

/* Sort bar */
.sort-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 12px;
  padding: 12px 0;
  margin-bottom: 16px;
  border-bottom: 1px solid var(--color-border);
}

.sort-options {
  display: flex;
  gap: 8px;
  overflow-x: auto;
}

.sort-btn {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 8px 14px;
  border: 1px solid var(--color-border);
  background: #fff;
  font-size: 13px;
  color: var(--color-text-main);
  cursor: pointer;
  border-radius: 2px;
  white-space: nowrap;
  transition: all 0.2s;
}

.sort-btn:hover {
  border-color: var(--color-primary);
}

.sort-btn.active {
  border-color: var(--color-primary);
  background: var(--color-primary);
  color: #fff;
}

.sort-arrows {
  display: inline-flex;
  flex-direction: column;
  gap: 2px;
}

.arrow {
  width: 0;
  height: 0;
  border-left: 4px solid transparent;
  border-right: 4px solid transparent;
}

.arrow-up {
  border-bottom: 4px solid currentColor;
  opacity: 0.4;
}

.arrow-down {
  border-top: 4px solid currentColor;
  opacity: 0.4;
}

.arrow.on {
  opacity: 1;
}

.price-filter-btn {
  flex-shrink: 0;
}

/* Price filter popup */
.price-filter-popup {
  padding: 24px;
}

.price-popup-title {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 20px;
  text-align: center;
}

.price-inputs {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 24px;
}

.price-input {
  flex: 1;
  min-width: 0;
  padding: 10px 12px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  font-size: 14px;
  outline: none;
  box-sizing: border-box;
  -moz-appearance: textfield;
}

.price-input::-webkit-outer-spin-button,
.price-input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

.price-input:focus {
  border-color: var(--color-primary);
}

.price-divider {
  color: var(--color-text-muted);
}

.price-popup-actions {
  display: flex;
  gap: 12px;
}

.price-popup-actions .shopify-btn {
  flex: 1;
}

.product-grid {
  display: grid;
  gap: 24px;
  margin-bottom: 40px;
}
.product-grid--pc {
  grid-template-columns: repeat(4, 1fr);
}
.product-grid--mobile {
  grid-template-columns: repeat(2, 1fr);
  gap: 16px;
}

@media (max-width: 767px) {
  .sort-bar {
    padding: 8px 0;
  }
  .sort-btn {
    padding: 6px 10px;
    font-size: 12px;
  }
}
</style>
