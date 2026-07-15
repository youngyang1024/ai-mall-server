<template>
  <page-shell title="注册" :show-back="isMobile" narrow>
    <div class="auth-card">
      <van-form @submit="onSubmit">
        <van-field v-model="form.username" label="用户名" placeholder="请输入用户名"
          :rules="[{ required: true, message: '请输入用户名' }]" />
        <van-field v-model="form.password" type="password" label="密码" placeholder="请输入密码"
          :rules="[{ required: true, message: '请输入密码' }]" />
        <van-field v-model="form.nickname" label="昵称" placeholder="选填" />
        <van-field v-model="form.phone" label="手机号" placeholder="选填" />
        <div style="margin: 16px;">
          <van-button round block type="danger" native-type="submit" :loading="loading">注册</van-button>
        </div>
      </van-form>
    </div>
  </page-shell>
</template>

<script>
import { register } from '@/api/auth'

export default {
  name: 'Register',
  data() {
    return { loading: false, form: { username: '', password: '', nickname: '', phone: '' } }
  },
  methods: {
    async onSubmit() {
      this.loading = true
      try {
        await register(this.form)
        this.$toast.success('注册成功，请登录')
        this.$router.replace('/login')
      } finally {
        this.loading = false
      }
    }
  }
}
</script>
