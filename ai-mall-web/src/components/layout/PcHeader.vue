<template>
  <header class="pc-header">
    <div class="pc-header__inner">
      <div class="header-left">
        <div class="pc-header__logo" @click="$router.push('/')">AI MALL</div>
        <nav class="pc-header__nav">
          <router-link to="/" exact class="nav-item">首页</router-link>
          <div
            v-for="cat in categories"
            :key="cat.id"
            class="nav-item nav-item--dropdown"
            @mouseenter="hoverCat = cat.id"
            @mouseleave="hoverCat = null"
          >
            <span @click="goCategory(cat.id)">{{ cat.name }}</span>
            <div v-if="hoverCat === cat.id && cat.children && cat.children.length" class="nav-dropdown">
              <a
                href="javascript:;"
                @click="goCategory(cat.id)"
                class="view-all-sub"
              >全部{{ cat.name }}</a>
              <a
                v-for="sub in cat.children"
                :key="sub.id"
                href="javascript:;"
                @click="goCategory(sub.id)"
              >{{ sub.name }}</a>
            </div>
          </div>
          <router-link to="/category" class="nav-item">全部分类</router-link>
          <router-link to="/coupon-center" class="nav-item">领券中心</router-link>
        </nav>
      </div>

      <div class="header-right">
        <div class="header-search">
          <i class="iconfont icon-search"></i>
          <input
            v-model="keyword"
            type="text"
            placeholder="搜索..."
            @keyup.enter="onSearch"
          />
        </div>
        <div class="header-actions">
          <template v-if="isLogin">
            <router-link to="/user" class="action-icon">
              <i class="van-icon van-icon-contact"></i>
              <span class="action-text">账户</span>
            </router-link>
          </template>
          <template v-else>
            <router-link to="/login" class="action-icon">
              <i class="van-icon van-icon-contact"></i>
              <span class="action-text">登录</span>
            </router-link>
          </template>
          <router-link to="/cart" class="action-icon cart-icon">
            <i class="van-icon van-icon-shopping-cart-o"></i>
            <span class="action-text">购物车</span>
            <!-- Could add a badge here if we had cart item count from vuex -->
          </router-link>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { getCategoryTree } from '@/api/product'

export default {
  name: 'PcHeader',
  data() {
    return {
      keyword: '',
      categories: [],
      hoverCat: null
    }
  },
  computed: {
    isLogin() {
      return this.$store.getters.isLogin
    }
  },
  async created() {
    try {
      const res = await getCategoryTree()
      this.categories = (res.data || []).slice(0, 4)
    } catch (e) {
      this.categories = []
    }
  },
  methods: {
    onSearch() {
      if (this.keyword.trim()) {
        this.$router.push({ path: '/product', query: { keyword: this.keyword.trim() } })
      }
    },
    goCategory(categoryId) {
      this.$router.push({ path: '/product', query: { categoryId } })
    }
  }
}
</script>

<style scoped>
.pc-header {
  position: sticky;
  top: 0;
  z-index: 1000;
  background: var(--color-background);
  border-bottom: 1px solid var(--color-border);
}

.pc-header__inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 80px;
  padding: 0 24px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 40px;
}

.pc-header__logo {
  font-size: 24px;
  font-weight: 800;
  letter-spacing: 1px;
  cursor: pointer;
  color: var(--color-primary);
}

.pc-header__nav {
  display: flex;
  align-items: center;
  gap: 24px;
}

.nav-item {
  position: relative;
  font-size: 14px;
  font-weight: 500;
  color: var(--color-primary);
  cursor: pointer;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  padding: 10px 0;
}

.nav-item::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 0;
  height: 2px;
  background: var(--color-primary);
  transition: width 0.3s ease;
}

.nav-item:hover::after,
.nav-item.router-link-active::after {
  width: 100%;
}

.nav-dropdown {
  position: absolute;
  top: 100%;
  left: -16px;
  min-width: 200px;
  background: var(--color-background);
  border: 1px solid var(--color-border);
  box-shadow: var(--shadow-md);
  padding: 12px 0;
  z-index: 10;
  opacity: 0;
  transform: translateY(10px);
  animation: fadeUp 0.2s forwards;
}

@keyframes fadeUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.nav-dropdown a {
  display: block;
  padding: 10px 24px;
  color: var(--color-text-main);
  font-size: 14px;
  transition: background 0.2s;
}

.nav-dropdown a:hover {
  background: var(--color-surface);
}

.view-all-sub {
  font-weight: 600;
  border-bottom: 1px solid var(--color-border);
}

.header-right {
  display: flex;
  align-items: center;
  gap: 32px;
}

.header-search {
  position: relative;
  display: flex;
  align-items: center;
}

.header-search .van-icon-search {
  position: absolute;
  left: 0;
  color: var(--color-text-muted);
  font-size: 18px;
}

.header-search input {
  border: none;
  border-bottom: 1px solid var(--color-border);
  padding: 8px 8px 8px 24px;
  width: 180px;
  font-size: 14px;
  outline: none;
  background: transparent;
  transition: border-color 0.3s, width 0.3s;
}

.header-search input:focus {
  border-bottom-color: var(--color-primary);
  width: 240px;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 24px;
}

.action-icon {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  color: var(--color-primary);
  cursor: pointer;
  transition: opacity 0.2s;
}

.action-icon:hover {
  opacity: 0.7;
}

.action-icon i {
  font-size: 22px;
}

.action-text {
  font-size: 12px;
  font-weight: 500;
}

.cart-icon {
  position: relative;
}
</style>
