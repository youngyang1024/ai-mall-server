<template>
  <page-shell title="商品分类" :show-back="isMobile" :with-tabbar-space="isMobile">
    <div class="category-layout">
      <van-sidebar v-model="activeKey">
        <van-sidebar-item
          v-for="(cat, idx) in categories"
          :key="cat.id"
          :title="cat.name"
          @click="activeKey = idx"
        />
      </van-sidebar>
      <div class="right-panel">
        <div v-if="currentCategory" class="category-banner">
          <h3>{{ currentCategory.name }}</h3>
          <p>探索更多 {{ currentCategory.name }} 精选好物</p>
        </div>
        <div class="sub-grid">
          <div
            v-for="sub in currentChildren"
            :key="sub.id"
            class="sub-card"
            @click="goList(sub.id)"
          >
            <div class="sub-card__icon" v-if="sub.name.startsWith('全部')"><van-icon name="apps-o" size="20" /></div>
            <div class="sub-card__icon" v-else>{{ sub.name.charAt(0) }}</div>
            <span>{{ sub.name }}</span>
          </div>
        </div>
      </div>
    </div>
  </page-shell>
</template>

<script>
import { getCategoryTree } from '@/api/product'

export default {
  name: 'CategoryPage',
  data() {
    return { categories: [], activeKey: 0 }
  },
  computed: {
    currentCategory() {
      return this.categories[this.activeKey] || null
    },
    currentChildren() {
      const cat = this.currentCategory
      if (!cat) return []
      const children = cat.children || []
      return [{ id: cat.id, name: '全部' + cat.name }, ...children]
    }
  },
  async created() {
    const res = await getCategoryTree()
    this.categories = res.data || []
  },
  methods: {
    goList(categoryId) {
      this.$router.push({ path: '/product', query: { categoryId } })
    }
  }
}
</script>

<style scoped>
.category-layout {
  display: flex;
  min-height: calc(100vh - 120px);
}
.right-panel {
  flex: 1;
  padding: 16px;
  background: #fff;
  border-radius: 8px;
}
.category-banner {
  padding: 16px;
  margin-bottom: 16px;
  background: linear-gradient(135deg, #1a1a1a, #333);
  border-radius: 8px;
  color: #fff;
}
.category-banner h3 {
  margin: 0 0 4px;
  font-size: 18px;
}
.category-banner p {
  margin: 0;
  font-size: 13px;
  opacity: 0.8;
}
.sub-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(100px, 1fr));
  gap: 12px;
}
.sub-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 16px 8px;
  border: 1px solid #f0f0f0;
  border-radius: 8px;
  cursor: pointer;
  transition: border-color 0.2s, box-shadow 0.2s;
}
.sub-card:hover {
  border-color: #c45500;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}
.sub-card__icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #f5f0eb;
  color: #c45500;
  font-weight: 700;
  line-height: 40px;
  text-align: center;
  margin-bottom: 8px;
}
.sub-card span {
  font-size: 13px;
  color: #323233;
  text-align: center;
}
</style>
