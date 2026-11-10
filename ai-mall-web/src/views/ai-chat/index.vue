<template>
  <div class="ai-chat-page">
    <!-- 顶部栏 -->
    <div class="ai-chat-header">
      <van-icon name="arrow-left" class="header-back" @click="$router.back()" />
      <div class="header-title">
        <span class="title-name">AI 购物助手</span>
        <span class="title-agent" v-if="currentAgentName">{{ currentAgentName }}为您服务</span>
      </div>
      <van-icon name="delete-o" class="header-clear" @click="startNewSession" />
    </div>

    <!-- 消息区 -->
    <div class="ai-chat-body" ref="chatBody">
      <!-- 欢迎语（无消息时展示） -->
      <div v-if="!messages.length" class="welcome-block">
        <div class="welcome-title">Hi，我是你的 AI 购物助手</div>
        <div class="welcome-desc">可以帮你推荐商品、解答购物问题、处理售后诉求</div>
        <div class="welcome-suggests">
          <div v-for="(q, i) in defaultSuggests" :key="i" class="suggest-chip" @click="sendMessage(q)">{{ q }}</div>
        </div>
      </div>

      <div v-for="msg in messages" :key="msg.key" class="msg-row" :class="msg.role === 'user' ? 'msg-user' : 'msg-ai'">
        <div class="msg-bubble">
          <span v-if="msg.content">{{ msg.content }}</span>
          <span v-else-if="msg.generating" class="typing-dots"><i></i><i></i><i></i></span>
        </div>
      </div>

      <!-- 快捷追问 -->
      <div v-if="suggests.length && !generating" class="welcome-suggests msg-suggests">
        <div v-for="(q, i) in suggests" :key="i" class="suggest-chip" @click="sendMessage(q)">{{ q }}</div>
      </div>
    </div>

    <!-- 输入区 -->
    <div class="ai-chat-footer">
      <van-field
        v-model="inputText"
        class="chat-input"
        placeholder="想买什么？有什么问题？尽管问我"
        :disabled="generating"
        @keyup.enter="sendMessage()"
      />
      <van-button
        v-if="generating"
        class="chat-send stop"
        size="small"
        @click="stopGenerating"
      >停止</van-button>
      <van-button
        v-else
        class="chat-send"
        size="small"
        :disabled="!inputText.trim()"
        @click="sendMessage()"
      >发送</van-button>
    </div>
  </div>
</template>

<script>
import { streamChat, stopChat, getSessionMessages, getGuestEid } from '@/api/ai-assistant'
import { Toast } from 'vant'

export default {
  name: 'AiChatPage',
  data() {
    return {
      sessionId: this.$route.query.sessionId || '',
      messages: [],
      inputText: '',
      generating: false,
      currentAgentName: '',
      suggests: [],
      defaultSuggests: ['退货运费谁承担？', '有什么优惠活动？', '帮我推荐一款沙发'],
      abortStream: null,
      currentMessageId: ''
    }
  },
  created() {
    getGuestEid()
    if (this.sessionId) {
      this.loadHistory()
    }
  },
  beforeDestroy() {
    if (this.abortStream) this.abortStream()
  },
  methods: {
    async loadHistory() {
      try {
        const res = await getSessionMessages(this.sessionId)
        this.messages = (res.data || []).map(m => ({
          key: m.messageId,
          role: m.role,
          content: m.content || '',
          generating: false
        }))
        this.scrollToBottom()
      } catch (e) {
        // 会话失效则开新会话
        this.sessionId = ''
      }
    },
    sendMessage(text) {
      const message = (text || this.inputText).trim()
      if (!message || this.generating) return
      this.inputText = ''
      this.suggests = []
      this.messages.push({ key: 'u-' + Date.now(), role: 'user', content: message, generating: false })
      const aiMsg = { key: 'a-' + Date.now(), role: 'assistant', content: '', generating: true }
      this.messages.push(aiMsg)
      this.generating = true
      this.scrollToBottom()

      this.abortStream = streamChat({ sessionId: this.sessionId, message }, {
        onEvent: event => this.handleEvent(event, aiMsg),
        onDone: () => this.finishGenerating(aiMsg),
        onError: () => {
          aiMsg.content = aiMsg.content || '生成失败，请稍后重试'
          this.finishGenerating(aiMsg)
        }
      })
    },
    handleEvent(event, aiMsg) {
      switch (event.type) {
        case 'start':
          this.sessionId = event.sessionId
          this.currentMessageId = event.messageId
          break
        case 'agent':
          this.currentAgentName = this.agentName(event.name)
          break
        case 'text-delta':
          aiMsg.content += event.delta
          this.scrollToBottom()
          break
        case 'suggest':
          this.suggests = event.questions || []
          break
        case 'error':
          aiMsg.content = aiMsg.content || event.message || '出错了，请稍后重试'
          if (event.code === 'quota_exceeded' && !this.$store.state.token) {
            Toast('登录后可提升每日额度')
          }
          break
        default:
          break
      }
    },
    finishGenerating(aiMsg) {
      aiMsg.generating = false
      this.generating = false
      this.abortStream = null
      this.currentMessageId = ''
      this.scrollToBottom()
    },
    async stopGenerating() {
      if (this.currentMessageId) {
        try {
          await stopChat(this.currentMessageId)
        } catch (e) { /* 停止失败不阻塞前端收尾 */ }
      }
      if (this.abortStream) this.abortStream()
      const last = this.messages[this.messages.length - 1]
      if (last && last.role === 'assistant') this.finishGenerating(last)
    },
    startNewSession() {
      if (this.generating) this.stopGenerating()
      this.sessionId = ''
      this.messages = []
      this.suggests = []
      this.currentAgentName = ''
    },
    agentName(code) {
      const names = {
        SHOPPING_GUIDE: '导购助手',
        CUSTOMER_SERVICE: '客服助手',
        AFTER_SALES: '售后助手',
        RULE: 'AI 助手'
      }
      return names[code] || 'AI 助手'
    },
    scrollToBottom() {
      this.$nextTick(() => {
        const el = this.$refs.chatBody
        if (el) el.scrollTop = el.scrollHeight
      })
    }
  }
}
</script>

<style scoped>
.ai-chat-page {
  display: flex;
  flex-direction: column;
  height: 100vh;
  background: #f7f8fa;
  max-width: 800px;
  margin: 0 auto;
}
.ai-chat-header {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  background: #fff;
  border-bottom: 1px solid #eee;
}
.header-back, .header-clear {
  font-size: 20px;
  color: #333;
  cursor: pointer;
}
.header-title {
  flex: 1;
  text-align: center;
}
.title-name {
  font-size: 16px;
  font-weight: 600;
  color: #222;
}
.title-agent {
  display: block;
  font-size: 11px;
  color: #999;
}
.ai-chat-body {
  flex: 1;
  overflow-y: auto;
  padding: 16px 12px;
}
.welcome-block {
  text-align: center;
  padding: 48px 24px 24px;
}
.welcome-title {
  font-size: 18px;
  font-weight: 600;
  color: #222;
}
.welcome-desc {
  margin-top: 8px;
  font-size: 13px;
  color: #888;
}
.welcome-suggests {
  margin-top: 20px;
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  justify-content: center;
}
.msg-suggests {
  justify-content: flex-start;
  padding-left: 4px;
}
.suggest-chip {
  padding: 8px 14px;
  background: #fff;
  border: 1px solid #e5e5e5;
  border-radius: 18px;
  font-size: 13px;
  color: #333;
  cursor: pointer;
}
.suggest-chip:active {
  background: #f2f2f2;
}
.msg-row {
  display: flex;
  margin-bottom: 12px;
}
.msg-user {
  justify-content: flex-end;
}
.msg-ai {
  justify-content: flex-start;
}
.msg-bubble {
  max-width: 78%;
  padding: 10px 14px;
  border-radius: 12px;
  font-size: 14px;
  line-height: 1.6;
  white-space: pre-wrap;
  word-break: break-word;
}
.msg-user .msg-bubble {
  background: #222;
  color: #fff;
  border-bottom-right-radius: 4px;
}
.msg-ai .msg-bubble {
  background: #fff;
  color: #333;
  border-bottom-left-radius: 4px;
  box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
}
.typing-dots i {
  display: inline-block;
  width: 6px;
  height: 6px;
  margin: 0 2px;
  background: #bbb;
  border-radius: 50%;
  animation: typing 1.2s infinite;
}
.typing-dots i:nth-child(2) { animation-delay: 0.2s; }
.typing-dots i:nth-child(3) { animation-delay: 0.4s; }
@keyframes typing {
  0%, 60%, 100% { transform: translateY(0); opacity: 0.4; }
  30% { transform: translateY(-4px); opacity: 1; }
}
.ai-chat-footer {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 10px 12px calc(10px + env(safe-area-inset-bottom));
  background: #fff;
  border-top: 1px solid #eee;
}
.chat-input {
  flex: 1;
  background: #f5f5f5;
  border-radius: 20px;
  padding: 6px 16px;
}
.chat-send {
  border-radius: 16px;
  background: #222;
  color: #fff;
  border: none;
  padding: 0 18px;
}
.chat-send.stop {
  background: #fff;
  color: #d03050;
  border: 1px solid #d03050;
}
.chat-send:disabled {
  opacity: 0.4;
}
</style>
