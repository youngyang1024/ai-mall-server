<template>
  <section v-if="products.length" class="recommend-section">
    <div class="recommend-section__header">
      <h2 class="recommend-section__title">{{ title }}</h2>
      <span v-if="subtitle" class="recommend-section__subtitle">{{ subtitle }}</span>
    </div>
    <div :class="['recommend-section__body', layoutClass]">
      <product-tile
        v-for="(item, index) in products"
        :key="item.id"
        :title="item.name"
        :price="formatPrice(item.minPrice)"
        :image="item.mainImage"
        :rank="showRank ? index + 1 : null"
        :sales-count="item.salesCount"
        @click="$router.push(`/product/${item.id}`)"
      />
    </div>
  </section>
</template>

<script>
export default {
  name: 'ProductRecommendSection',
  props: {
    title: { type: String, required: true },
    subtitle: { type: String, default: '' },
    products: { type: Array, default: () => [] },
    showRank: { type: Boolean, default: false },
    horizontal: { type: Boolean, default: false }
  },
  computed: {
    layoutClass() {
      if (this.horizontal) return 'recommend-section__scroll'
      return 'recommend-section__grid'
    }
  },
  methods: {
    formatPrice(price) {
      if (price == null || price === '') return '0.00'
      return Number(price).toFixed(2)
    }
  }
}
</script>

<style scoped>
.recommend-section {
  margin-top: 40px;
  margin-bottom: 40px;
}
.recommend-section__header {
  display: flex;
  align-items: baseline;
  gap: 12px;
  margin-bottom: 24px;
}
.recommend-section__title {
  margin: 0;
  font-size: 28px;
  font-weight: 700;
  color: var(--color-primary);
}
.recommend-section__subtitle {
  font-size: 14px;
  color: var(--color-text-muted);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}
.recommend-section__scroll {
  display: flex;
  gap: 16px;
  overflow-x: auto;
  padding-bottom: 12px;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: thin;
}
.recommend-section__scroll::-webkit-scrollbar {
  height: 4px;
}
.recommend-section__scroll::-webkit-scrollbar-thumb {
  background-color: var(--color-border);
  border-radius: 4px;
}
.recommend-section__scroll .product-tile {
  flex: 0 0 280px;
}
@media (max-width: 767px) {
  .recommend-section__scroll .product-tile {
    flex: 0 0 160px;
  }
  .recommend-section__title {
    font-size: 22px;
  }
}

.recommend-section__grid {
  display: grid;
  gap: 24px;
}

@media (min-width: 768px) {
  .recommend-section__grid {
    grid-template-columns: repeat(4, 1fr);
  }
}

@media (max-width: 767px) {
  .recommend-section__grid {
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
  }
}
</style>
