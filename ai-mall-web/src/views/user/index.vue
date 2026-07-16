<template>
  <div class="user-dashboard">
    <template v-if="isLogin">
      <!-- 顶部欢迎卡片 -->
      <div class="dashboard-card profile-summary-card">
        <div class="card-header border-bottom">
          <h2 class="welcome-text">Hi, {{ userInfo.nickname || userInfo.username }}</h2>
          <div class="header-links">
            <a href="javascript:;" class="edit-link" @click="showProfile = true">编辑资料 ></a>
            <a href="javascript:;" class="edit-link" @click="openPasswordForm">修改密码 ></a>
          </div>
        </div>
        <div class="stats-grid">
              <div class="stat-item" @click="$router.push('/coupon?status=0')">
            <div class="stat-value">{{ myCouponCount }}</div>
            <div class="stat-label">优惠券</div>
          </div>
          <div class="stat-item disabled">
            <div class="stat-value">0</div>
            <div class="stat-label">积分</div>
          </div>
          <div class="stat-item" @click="$router.push('/user/favorite')">
            <div class="stat-value">{{ favoriteCount }}</div>
            <div class="stat-label">心愿单</div>
          </div>
          <div class="stat-item disabled">
            <div class="stat-value">0</div>
            <div class="stat-label">足迹</div>
          </div>
        </div>
      </div>

      <!-- 我的订单卡片 -->
      <div class="dashboard-card orders-summary-card">
        <div class="card-header border-bottom">
          <h2 class="card-title">我的订单</h2>
          <router-link to="/order" class="view-all-link">查看全部 ></router-link>
        </div>
        <div class="order-status-grid">
          <router-link to="/order?status=0" class="status-item">
            <van-icon name="pending-payment" size="32" />
            <div class="status-label">待支付</div>
          </router-link>
          <router-link to="/order?status=1" class="status-item">
            <van-icon name="send-gift-o" size="32" />
            <div class="status-label">待发货</div>
          </router-link>
          <router-link to="/order?status=2" class="status-item">
            <van-icon name="logistics" size="32" />
            <div class="status-label">已发货</div>
          </router-link>
          <router-link to="/refund" class="status-item">
            <van-icon name="after-sale" size="32" />
            <div class="status-label">售后中心</div>
          </router-link>
        </div>
      </div>
      
      <!-- 移动端额外入口 -->
      <div class="dashboard-card mobile-nav-card" v-if="isMobile">
        <van-cell title="收货地址" is-link to="/user/address" />
        <van-cell title="我的评价" is-link to="/user/review" />
        <van-cell title="修改密码" is-link @click="openPasswordForm" />
        <van-cell title="退出登录" is-link @click="handleLogout" />
      </div>
    </template>

    <template v-else>
      <div class="dashboard-card guest-state">
        <van-icon name="user-circle-o" size="64" color="var(--color-border)" />
        <p class="guest-text">您尚未登录，请登录后查看账户信息</p>
        <div class="guest-actions">
          <button class="shopify-btn" @click="$router.push('/login')">登录</button>
          <button class="shopify-btn shopify-btn--outline" @click="$router.push('/register')">注册</button>
        </div>
      </div>
    </template>

    <!-- 资料修改弹窗 -->
    <van-popup 
      v-model="showProfile" 
      :position="isMobile ? 'bottom' : 'center'" 
      round 
      :class="isMobile ? 'mobile-popup' : 'pc-popup'"
      :style="isMobile ? { height: 'auto' } : { width: '420px' }"
      closeable
    >
      <div class="popup-header">修改资料</div>
      <div class="popup-content">
        <van-form @submit="saveProfile" class="profile-form">
          <div class="form-group">
            <label>昵称</label>
            <input type="text" v-model="profileForm.nickname" class="custom-input" placeholder="请输入昵称" />
          </div>
          <div class="form-group">
            <label>手机号</label>
            <input type="tel" v-model="profileForm.phone" class="custom-input" placeholder="请输入手机号" />
          </div>
          <button class="shopify-btn submit-btn" type="submit">保存更改</button>
        </van-form>
      </div>
    </van-popup>

    <!-- 修改密码弹窗 -->
    <van-popup
      v-model="showPassword"
      :position="isMobile ? 'bottom' : 'center'"
      round
      :class="isMobile ? 'mobile-popup' : 'pc-popup'"
      :style="isMobile ? { height: 'auto' } : { width: '420px' }"
      closeable
    >
      <div class="popup-header">修改密码</div>
      <div class="popup-content">
        <form class="profile-form" @submit.prevent="savePassword">
          <div class="form-group">
            <label>当前密码</label>
            <input type="password" v-model="passwordForm.oldPassword" class="custom-input" placeholder="请输入当前密码" autocomplete="current-password" />
          </div>
          <div class="form-group">
            <label>新密码</label>
            <input type="password" v-model="passwordForm.newPassword" class="custom-input" placeholder="请输入新密码（至少6位）" autocomplete="new-password" />
          </div>
          <div class="form-group">
            <label>确认新密码</label>
            <input type="password" v-model="passwordForm.confirmPassword" class="custom-input" placeholder="请再次输入新密码" autocomplete="new-password" />
          </div>
          <button class="shopify-btn submit-btn" type="submit" :disabled="passwordSubmitting">
            {{ passwordSubmitting ? '提交中...' : '确认修改' }}
          </button>
        </form>
      </div>
    </van-popup>
  </div>
</template>

<script>
import { logout } from '@/api/auth'
import { getUserInfo, updateUserInfo, updatePassword } from '@/api/user'
import { getMyCoupons } from '@/api/coupon'
import { getFavoriteCount } from '@/api/favorite'

export default {
  name: 'UserCenter',
  data() {
    return {
      showProfile: false,
      profileForm: { nickname: '', phone: '' },
      myCouponCount: 0,
      favoriteCount: 0,
      showPassword: false,
      passwordSubmitting: false,
      passwordForm: { oldPassword: '', newPassword: '', confirmPassword: '' }
    }
  },
  computed: {
    isLogin() { return this.$store.getters.isLogin },
    userInfo() { return this.$store.state.userInfo || {} }
  },
  async created() {
    if (this.isLogin) {
      if (!this.userInfo.id) {
        const res = await getUserInfo()
        this.$store.commit('SET_USER_INFO', res.data)
      }
      this.loadCoupons()
      this.loadFavoriteCount()
    }
  },
  methods: {
    isOrderStatus(status) {
      return this.$route.path === '/order' && String(this.$route.query.status) === String(status)
    },
    async loadCoupons() {
      try {
        const res = await getMyCoupons()
        this.myCouponCount = (res.data || []).length
      } catch (e) {
        // ignore
      }
    },
    async loadFavoriteCount() {
      try {
        const res = await getFavoriteCount()
        this.favoriteCount = res.data || 0
      } catch (e) {
        // ignore
      }
    },
    openPasswordForm() {
      this.passwordForm = { oldPassword: '', newPassword: '', confirmPassword: '' }
      this.showPassword = true
    },
    async savePassword() {
      const { oldPassword, newPassword, confirmPassword } = this.passwordForm
      if (!oldPassword) {
        this.$toast('请输入当前密码')
        return
      }
      if (!newPassword || newPassword.length < 6) {
        this.$toast('新密码至少6位')
        return
      }
      if (newPassword !== confirmPassword) {
        this.$toast('两次输入的新密码不一致')
        return
      }
      this.passwordSubmitting = true
      try {
        await updatePassword({ oldPassword, newPassword })
        this.showPassword = false
        this.$toast.success('密码修改成功，请重新登录')
        this.$store.commit('SET_TOKEN', '')
        this.$store.commit('SET_USER_INFO', null)
        this.$router.push('/login')
      } catch (e) {
        // error handled globally
      } finally {
        this.passwordSubmitting = false
      }
    },
    async handleLogout() {
      try { await logout() } catch (e) { /* ignore */ }
      this.$store.commit('SET_TOKEN', '')
      this.$store.commit('SET_USER_INFO', null)
      this.$toast('已退出登录')
      this.$router.push('/login')
    },
    openProfile() {
      this.profileForm = { nickname: this.userInfo.nickname, phone: this.userInfo.phone }
      this.showProfile = true
    },
    async saveProfile() {
      await updateUserInfo(this.profileForm)
      const res = await getUserInfo()
      this.$store.commit('SET_USER_INFO', res.data)
      this.showProfile = false
      this.$toast.success('保存成功')
    }
  },
  watch: {
    showProfile(val) {
      if (val) this.openProfile()
    }
  }
}
</script>

<style scoped>
.user-dashboard {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.dashboard-card {
  background: #fff;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 24px;
}
.card-header.border-bottom {
  border-bottom: 1px solid var(--color-border);
}
.welcome-text {
  font-size: 18px;
  font-weight: 600;
  margin: 0;
}
.header-links {
  display: flex;
  gap: 16px;
}
.edit-link {
  font-size: 13px;
  color: var(--color-text-muted);
}
.edit-link:hover {
  color: var(--color-primary);
}
.card-title {
  font-size: 16px;
  font-weight: 600;
  margin: 0;
}
.view-all-link {
  font-size: 13px;
  color: var(--color-text-main);
  font-weight: 500;
}
.view-all-link:hover {
  text-decoration: underline;
}

/* Stats Grid */
.stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  text-align: center;
  padding: 32px 0;
}
.stat-item {
  cursor: pointer;
}
.stat-item.disabled {
  cursor: default;
  opacity: 0.5;
}
.stat-value {
  font-size: 24px;
  font-weight: 600;
  margin-bottom: 8px;
}
.stat-label {
  font-size: 13px;
  color: var(--color-text-muted);
}

/* Order Status Grid */
.order-status-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  text-align: center;
  padding: 40px 0;
}
.status-item {
  color: var(--color-text-main);
  transition: color 0.2s;
}
.status-item:hover {
  color: var(--color-primary);
}
.status-label {
  font-size: 13px;
  margin-top: 12px;
}

/* Guest State */
.guest-state {
  text-align: center;
  padding: 80px 0;
}
.guest-text {
  font-size: 16px;
  color: var(--color-text-muted);
  margin: 24px 0 32px;
}
.guest-actions {
  display: flex;
  gap: 16px;
  justify-content: center;
}
.guest-actions .shopify-btn {
  min-width: 120px;
}

/* Form Styles */
.popup-header {
  text-align: center;
  font-size: 18px;
  font-weight: 500;
  padding: 20px;
  border-bottom: 1px solid var(--color-border);
}
.profile-form {
  padding: 24px;
}
.form-group {
  margin-bottom: 20px;
}
.form-group label {
  display: block;
  font-size: 13px;
  font-weight: 500;
  margin-bottom: 8px;
  color: var(--color-text-main);
}
.custom-input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
  font-size: 14px;
  outline: none;
  box-sizing: border-box;
}
.custom-input:focus {
  border-color: var(--color-primary);
}
.submit-btn {
  width: 100%;
  margin-top: 12px;
}

@media (max-width: 767px) {
  .user-dashboard {
    gap: 16px;
  }
  .stats-grid {
    padding: 24px 0;
  }
  .order-status-grid {
    padding: 24px 0;
  }
  .stat-value {
    font-size: 20px;
  }
  .card-header {
    padding: 16px;
  }
  .mobile-nav-card {
    margin-top: 16px;
    border: none;
    border-radius: var(--radius-md);
    overflow: hidden;
  }
}
</style>
