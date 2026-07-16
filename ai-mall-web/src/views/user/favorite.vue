<template>
  <div class="favorite-page">
    <div v-if="list.length" class="favorite-list">
      <div
        v-for="item in list"
        :key="item.spuId"
        class="favorite-item"
        :class="{ 'is-off': item.spuStatus === 0 }"
      >
        <div class="item-img-wrap" @click="goProduct(item)">
          <img :src="item.mainImage" class="item-img" alt="" />
          <span class="off-badge" v-if="item.spuStatus === 0">已下架</span>
        </div>
        <div class="item-info">
          <div class="item-name" @click="goProduct(item)">{{ item.spuName }}</div>
          <div class="item-price">¥{{ formatPrice(item.minPrice) }}</div>
          <div class="item-time">收藏于 {{ formatTime(item.createTime) }}</div>
        </div>
        <div class="item-action">
          <button class="remove-btn" @click="handleRemove(item)">
            <van-icon name="delete-o" size="16" /> 移除
          </button>
        </div>
      </div>
    </div>

    <div v-else-if="!loading" class="empty-state">
      <van-icon name="like-o" size="48" color="var(--color-border)" />
      <p>心愿单还是空的，去挑选喜欢的商品吧</p>
      <button class="shopify-btn" @click="$router.push('/category')">去逛逛</button>
    </div>

    <div class="load-more" v-if="list.length < total">
      <button class="shopify-btn shopify-btn--outline" :disabled="loading" @click="loadData()">
        {{ loading ? '加载中...' : '加载更多' }}
      </button>
    </div>
  </div>
</template>

<script>
import { getFavoriteList, removeFavorite } from '@/api/favorite'

export default {
  name: 'UserFavoritePage',
  data() {
    return {
      list: [],
      total: 0,
      pageNum: 1,
      pageSize: 10,
      loading: false
    }
  },
  created() {
    this.loadData(true)
  },
  methods: {
    formatPrice(price) {
      if (price == null) return '0.00'
      return Number(price).toFixed(2)
    },
    formatTime(timeStr) {
      if (!timeStr) return ''
      return String(timeStr).replace('T', ' ').slice(0, 10)
    },
    goProduct(item) {
      if (item.spuStatus === 0) {
        this.$toast('该商品已下架')
        return
      }
      this.$router.push('/product/' + item.spuId)
    },
    async loadData(reset = false) {
      if (reset) {
        this.pageNum = 1
        this.list = []
        this.total = 0
      }
      this.loading = true
      try {
        const res = await getFavoriteList({ pageNum: this.pageNum, pageSize: this.pageSize })
        const data = res.data || {}
        this.list = this.list.concat(data.list || [])
        this.total = data.total || 0
        this.pageNum++
      } catch (e) {
        // error handled globally
      } finally {
        this.loading = false
      }
    },
    async handleRemove(item) {
      try {
        await this.$dialog.confirm({ title: '确认从心愿单移除该商品？' })
      } catch (e) {
        return
      }
      await removeFavorite(item.spuId)
      this.$toast.success('已移除')
      this.loadData(true)
    }
  }
}
</script>

<style scoped>
.favorite-page {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  min-height: 400px;
}

.favorite-list {
  padding: 0 24px;
}

.favorite-item {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px 0;
  border-bottom: 1px solid var(--color-surface);
}

.favorite-item:last-child {
  border-bottom: none;
}

.favorite-item.is-off .item-img,
.favorite-item.is-off .item-info {
  opacity: 0.5;
  filter: grayscale(0.8);
}

.item-img-wrap {
  position: relative;
  flex-shrink: 0;
  cursor: pointer;
}

.item-img {
  width: 88px;
  height: 88px;
  object-fit: cover;
  border-radius: var(--radius-sm);
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  display: block;
}

.off-badge {
  position: absolute;
  left: 0;
  bottom: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.6);
  color: #fff;
  font-size: 11px;
  text-align: center;
  padding: 2px 0;
  border-radius: 0 0 var(--radius-sm) var(--radius-sm);
}

.item-info {
  flex: 1;
  min-width: 0;
}

.item-name {
  font-size: 14px;
  font-weight: 500;
  margin-bottom: 8px;
  cursor: pointer;
  line-height: 1.4;
}

.item-name:hover {
  text-decoration: underline;
}

.item-price {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 8px;
}

.item-time {
  font-size: 12px;
  color: var(--color-text-muted);
}

.item-action {
  flex-shrink: 0;
}

.remove-btn {
  background: none;
  border: none;
  padding: 4px;
  font-size: 13px;
  color: var(--color-text-muted);
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 4px;
}

.remove-btn:hover {
  color: #ee0a24;
}

.empty-state {
  text-align: center;
  padding: 64px 0;
  color: var(--color-text-muted);
  font-size: 14px;
}

.empty-state p {
  margin: 16px 0 24px;
}

.load-more {
  text-align: center;
  padding: 24px;
}

@media (max-width: 767px) {
  .favorite-page {
    border: none;
    border-radius: 0;
  }
  .favorite-list {
    padding: 0 16px;
  }
  .item-img {
    width: 72px;
    height: 72px;
  }
}
</style>
