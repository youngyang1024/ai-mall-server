<template>
  <page-shell title="登录" :show-back="isMobile" narrow>
    <div class="auth-card">
      <van-form @submit="onSubmit">
        <van-field v-model="form.username" name="username" label="用户名" placeholder="请输入用户名"
          :rules="[{ required: true, message: '请输入用户名' }]" />
        <van-field v-model="form.password" type="password" name="password" label="密码" placeholder="请输入密码"
          :rules="[{ required: true, message: '请输入密码' }]" />
        <div style="margin: 16px;">
          <van-button round block type="danger" native-type="submit" :loading="loading">登录</van-button>
          <van-button round block plain type="danger" style="margin-top:12px" @click="$router.push('/register')">注册账号</van-button>
        </div>
      </van-form>
    </div>
  </page-shell>
</template>

<script>
import { login } from '@/api/auth'
import { getUserInfo } from '@/api/user'
import { bindGuestSessions } from '@/api/ai-assistant'

export default {
  name: 'Login',
  data() {
    return { loading: false, form: { username: '', password: '' } }
  },
  methods: {
    async onSubmit() {
      this.loading = true
      try {
        const res = await login(this.form)
        this.$store.commit('SET_TOKEN', res.data.token)
        const infoRes = await getUserInfo()
        this.$store.commit('SET_USER_INFO', infoRes.data)
        // 游客期的 AI 会话绑定到登录用户（失败不影响登录流程）
        bindGuestSessions().catch(() => {})
        this.$toast.success('登录成功')
        this.$router.replace(this.$route.query.redirect || '/user')
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
