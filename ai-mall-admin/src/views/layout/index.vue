<template>
  <el-container class="layout">
    <el-aside width="200px" class="aside">
      <div class="logo">AI Mall</div>
      <el-menu :default-active="$route.path" router background-color="#304156" text-color="#bfcbd9" active-text-color="#409EFF">
        <el-menu-item index="/"><i class="el-icon-s-home"></i><span>首页</span></el-menu-item>
        <el-menu-item index="/category"><i class="el-icon-menu"></i><span>分类管理</span></el-menu-item>
        <el-menu-item index="/product"><i class="el-icon-goods"></i><span>商品管理</span></el-menu-item>
        <el-menu-item index="/order"><i class="el-icon-s-order"></i><span>订单管理</span></el-menu-item>
        <el-menu-item index="/banner"><i class="el-icon-picture-outline"></i><span>轮播图管理</span></el-menu-item>
        <el-menu-item index="/hot-search"><i class="el-icon-search"></i><span>热门搜索</span></el-menu-item>
        <el-menu-item index="/coupon"><i class="el-icon-s-ticket"></i><span>优惠券管理</span></el-menu-item>
        <el-menu-item index="/refund"><i class="el-icon-refresh-left"></i><span>退款审核</span></el-menu-item>
        <el-menu-item index="/service-ticket"><i class="el-icon-service"></i><span>工单管理</span></el-menu-item>
        <el-menu-item index="/user"><i class="el-icon-user"></i><span>用户管理</span></el-menu-item>
        <el-menu-item index="/faq"><i class="el-icon-question"></i><span>帮助中心</span></el-menu-item>
        <el-menu-item index="/review"><i class="el-icon-chat-line-square"></i><span>评价管理</span></el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header class="header">
        <div></div>
        <div class="right">
          <span class="nickname">{{ userInfo.nickname || userInfo.username }}</span>
          <el-button type="text" @click="handleLogout">退出</el-button>
        </div>
      </el-header>
      <el-main>
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import { logout } from '@/api/auth'

export default {
  name: 'Layout',
  computed: {
    userInfo() {
      return this.$store.state.userInfo || {}
    }
  },
  methods: {
    async handleLogout() {
      try { await logout() } catch (e) { /* ignore */ }
      this.$store.commit('SET_TOKEN', '')
      this.$store.commit('SET_USER_INFO', null)
      this.$router.push('/login')
    }
  }
}
</script>

<style scoped>
.layout { min-height: 100vh; }
.aside { background: #304156; }
.logo { height: 60px; line-height: 60px; text-align: center; color: #fff; font-weight: bold; }
.header { display: flex; align-items: center; justify-content: space-between; background: #fff; border-bottom: 1px solid #ebeef5; }
.right { display: flex; align-items: center; gap: 12px; }
.nickname { color: #606266; }
</style>
