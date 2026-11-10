<template>
  <div class="ai-entry" @click="goChat">
    <span class="ai-entry-icon">AI</span>
    <span class="ai-entry-text">购物助手</span>
  </div>
</template>

<script>
// 首页悬浮 AI 会话入口（PC 右下角气泡 / M 端底部偏上），点击进入聊天页
export default {
  name: 'AiAssistantEntry',
  methods: {
    goChat() {
      this.$router.push('/ai-chat')
    }
  }
}
</script>

<style scoped>
.ai-entry {
  position: fixed;
  right: 20px;
  bottom: 96px;
  z-index: 99;
  display: flex;
  align-items: center;
  gap: 6px;
  padding: 10px 16px;
  background: #222;
  color: #fff;
  border-radius: 24px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.24);
  cursor: pointer;
  transition: transform 0.15s;
}
.ai-entry:hover {
  transform: scale(1.05);
}
.ai-entry-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 22px;
  background: #fff;
  color: #222;
  border-radius: 50%;
  font-size: 11px;
  font-weight: 700;
}
.ai-entry-text {
  font-size: 13px;
  font-weight: 500;
}
@media (min-width: 769px) {
  .ai-entry {
    right: 32px;
    bottom: 48px;
  }
}
</style>
