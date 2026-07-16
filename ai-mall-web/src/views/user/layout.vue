<template>
  <page-shell :title="pageTitle" :with-tabbar-space="isMobile && $route.path === '/user'">
    <div class="user-layout-container">
      <!-- PC端左侧边栏导航 -->
      <aside class="sidebar-nav" v-if="!isMobile && isLogin">
        <h2 class="sidebar-title">我的账户</h2>
        
        <div class="nav-group">
          <router-link to="/order" custom v-slot="{ navigate }">
            <h3 class="group-title clickable-title" @click="navigate" :class="{ active: isOrderList && !isStatus(0) && !isStatus(1) && !isStatus(2) }">
              订单中心
            </h3>
          </router-link>
          <ul class="nav-list">
            <li><router-link to="/order?status=0" :class="{ active: isOrderList && isStatus(0) }">待支付</router-link></li>
            <li><router-link to="/order?status=1" :class="{ active: isOrderList && isStatus(1) }">待发货</router-link></li>
            <li><router-link to="/order?status=2" :class="{ active: isOrderList && isStatus(2) }">已发货</router-link></li>
            <li><router-link to="/refund" :class="{ active: $route.path.startsWith('/refund') }">售后中心</router-link></li>
            <li><router-link to="/user/review" :class="{ active: $route.path === '/user/review' }">我的评价</router-link></li>
          </ul>
        </div>

        <div class="nav-group">
          <h3 class="group-title">我的资产</h3>
          <ul class="nav-list">
            <li><router-link to="/coupon?status=0" :class="{ active: $route.path === '/coupon' }">我的优惠券</router-link></li>
            <li><a href="javascript:;" class="disabled">我的积分</a></li>
          </ul>
        </div>

        <div class="nav-group">
          <h3 class="group-title">账户设置</h3>
          <ul class="nav-list">
            <li><router-link to="/user" exact-active-class="active">个人资料</router-link></li>
            <li><router-link to="/user/address" :class="{ active: $route.path === '/user/address' }">收货地址</router-link></li>
            <li><router-link to="/service-ticket" :class="{ active: $route.path.startsWith('/service-ticket') }">我的工单</router-link></li>
            <li><router-link to="/user/favorite" :class="{ active: $route.path === '/user/favorite' }">我的心愿单</router-link></li>
            <li><a href="javascript:;" class="disabled">浏览记录</a></li>
          </ul>
        </div>
        
        <div class="nav-group logout-group">
          <button class="logout-btn" @click="handleLogout">退出登录</button>
        </div>
      </aside>

      <!-- 右侧/移动端主要内容区（嵌套路由） -->
      <main class="dashboard-content">
        <router-view />
      </main>
    </div>
  </page-shell>
</template>

<script>
import { logout } from '@/api/auth'

export default {
  name: 'UserLayout',
  computed: {
    isLogin() { return this.$store.getters.isLogin },
    pageTitle() {
      if (this.$route.path === '/user') return '个人中心'
      if (this.$route.path === '/user/review') return '我的评价'
      if (this.$route.path === '/user/favorite') return '我的心愿单'
      if (this.$route.path.startsWith('/order')) return '我的订单'
      if (this.$route.path.startsWith('/coupon')) return '优惠券'
      if (this.$route.path.startsWith('/refund')) return '售后中心'
      if (this.$route.path.startsWith('/service-ticket')) return '我的工单'
      if (this.$route.path === '/user/address') return '收货地址'
      return '我的账户'
    },
    isOrderList() {
      return this.$route.path === '/order'
    }
  },
  methods: {
    isStatus(status) {
      return String(this.$route.query.status) === String(status)
    },
    async handleLogout() {
      try { await logout() } catch (e) { /* ignore */ }
      this.$store.commit('SET_TOKEN', '')
      this.$store.commit('SET_USER_INFO', null)
      this.$toast('已退出登录')
      this.$router.push('/login')
    }
  }
}
</script>

<style scoped>
.user-layout-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 40px 16px;
  display: grid;
  grid-template-columns: 240px 1fr;
  gap: 40px;
  align-items: start;
}

/* Sidebar Nav */
.sidebar-nav {
  background: var(--color-surface);
  padding: 24px;
  border-radius: var(--radius-md);
  position: sticky;
  top: 24px;
}
.sidebar-title {
  font-size: 20px;
  font-weight: 600;
  margin-bottom: 24px;
  margin-top: 0;
}
.nav-group {
  margin-bottom: 32px;
}
.nav-group:last-child {
  margin-bottom: 0;
}
.group-title {
  font-size: 14px;
  font-weight: 600;
  margin-bottom: 12px;
  color: var(--color-text-main);
}
.clickable-title {
  cursor: pointer;
  transition: color 0.2s;
}
.clickable-title:hover, .clickable-title.active {
  color: var(--color-primary);
}
.nav-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.nav-list li {
  margin-bottom: 12px;
}
.nav-list a {
  font-size: 14px;
  color: var(--color-text-muted);
  text-decoration: none;
  transition: color 0.2s;
  display: block;
}
.nav-list a:hover {
  color: var(--color-primary);
}
.nav-list a.active {
  color: var(--color-primary);
  font-weight: 600;
}
.nav-list a.disabled {
  color: #ccc;
  cursor: not-allowed;
}
.logout-btn {
  background: none;
  border: none;
  color: #ee0a24;
  padding: 0;
  font-size: 14px;
  cursor: pointer;
}

/* Dashboard Content */
.dashboard-content {
  min-height: 500px;
}

@media (max-width: 767px) {
  .user-layout-container {
    grid-template-columns: 1fr;
    padding: 0;
    gap: 0;
  }
  .sidebar-nav {
    display: none;
  }
}
</style>
