<template>
  <page-shell :title="pageTitle" :show-back="isMobile">
    <div v-if="keyword" class="list-head">
      <span>搜索「{{ keyword }}」</span>
    </div>
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
      recommendProducts: []
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
      return `${this.categoryId || ''}_${this.keyword || ''}`
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
</style>
