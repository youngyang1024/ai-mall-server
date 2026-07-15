<template>
  <div class="product-tile" @click="$emit('click')">
    <div class="product-tile__image-wrap">
      <span v-if="rank" class="product-tile__badge rank-badge">TOP {{ rank }}</span>
      <span v-else-if="Math.random() > 0.7" class="product-tile__badge sale-badge">Sale</span>
      
      <img :src="image" :alt="title" class="product-tile__img" />
      
      <!-- Quick Add Overlay (PC only) -->
      <div class="product-tile__overlay">
        <button class="quick-view-btn">快速预览</button>
      </div>
    </div>
    
    <div class="product-tile__info">
      <div class="product-tile__title">{{ title }}</div>
      <div class="product-tile__price-row">
        <span class="price-current">¥{{ Number(price).toFixed(2) }}</span>
        <span class="price-original">¥{{ (Number(price) * 1.2).toFixed(2) }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ProductTile',
  props: {
    title: String,
    price: [String, Number],
    image: String,
    rank: Number,
    salesCount: { type: Number, default: 0 }
  }
}
</script>

<style scoped>
.product-tile {
  cursor: pointer;
  group: relative;
  display: flex;
  flex-direction: column;
  height: 100%;
}

.product-tile__image-wrap {
  position: relative;
  aspect-ratio: 1; /* Common for Shopify, can be 4/5 */
  background: var(--color-surface);
  overflow: hidden;
  margin-bottom: 16px;
  border-radius: var(--radius-sm);
}

.product-tile__img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.product-tile:hover .product-tile__img {
  transform: scale(1.04);
}

.product-tile__badge {
  position: absolute;
  top: 10px;
  left: 10px;
  z-index: 2;
  padding: 4px 10px;
  font-size: 11px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  border-radius: 2px;
}

.rank-badge {
  background: var(--color-primary);
  color: #fff;
}

.sale-badge {
  background: var(--color-accent);
  color: #fff;
}

.product-tile__overlay {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  padding: 16px;
  background: linear-gradient(to top, rgba(0,0,0,0.1), transparent);
  transform: translateY(100%);
  opacity: 0;
  transition: all 0.3s ease;
  display: flex;
  justify-content: center;
}

@media (min-width: 768px) {
  .product-tile:hover .product-tile__overlay {
    transform: translateY(0);
    opacity: 1;
  }
}

.quick-view-btn {
  width: 100%;
  padding: 10px 0;
  background: rgba(255, 255, 255, 0.95);
  border: none;
  font-size: 13px;
  font-weight: 600;
  color: var(--color-primary);
  cursor: pointer;
  border-radius: 2px;
  box-shadow: var(--shadow-sm);
  transition: background 0.2s;
}

.quick-view-btn:hover {
  background: #fff;
}

.product-tile__info {
  display: flex;
  flex-direction: column;
  flex: 1;
}

.product-tile__title {
  font-size: 14px;
  color: var(--color-text-main);
  line-height: 1.4;
  margin-bottom: 8px;
  /* Max 2 lines */
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  transition: color 0.2s;
}

.product-tile:hover .product-tile__title {
  color: var(--color-accent);
}

.product-tile__price-row {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: auto;
}

.price-current {
  font-size: 15px;
  font-weight: 600;
  color: var(--color-primary);
}

.price-original {
  font-size: 13px;
  color: var(--color-text-muted);
  text-decoration: line-through;
}
</style>
