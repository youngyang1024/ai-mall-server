// AI 助手接口封装
// - 普通接口走 axios（自动带 Authorization），额外补 X-Guest-Eid 游客头
// - SSE 流式接口用 fetch + ReadableStream（EventSource 不支持 POST）
import request from '@/utils/request'
import store from '@/store'

const AGENT_BASE = '/agent'

// 游客标识：首次生成 UUID 存 localStorage，登录前所有请求携带
export function getGuestEid() {
  let eid = localStorage.getItem('ai_guest_eid')
  if (!eid) {
    eid = 'g-' + Date.now().toString(36) + '-' + Math.random().toString(36).slice(2, 10)
    localStorage.setItem('ai_guest_eid', eid)
  }
  return eid
}

function guestHeaders() {
  return { 'X-Guest-Eid': getGuestEid() }
}

export function getSessionList() {
  return request.get(`${AGENT_BASE}/session/list`, { headers: guestHeaders() })
}

export function getSessionMessages(sessionId, page = 1, size = 50) {
  return request.get(`${AGENT_BASE}/session/${sessionId}/messages`, {
    params: { page, size },
    headers: guestHeaders()
  })
}

export function getQuota() {
  return request.get(`${AGENT_BASE}/session/quota`, { headers: guestHeaders() })
}

// 登录成功后调用：将游客期会话绑定到登录用户
export function bindGuestSessions() {
  return request.post(`${AGENT_BASE}/session/bind`, { eid: getGuestEid() }, { headers: guestHeaders() })
}

export function stopChat(messageId) {
  return request.post(`${AGENT_BASE}/chat/stop`, { messageId }, { headers: guestHeaders() })
}

/**
 * SSE 流式对话
 * @param {Object} payload {sessionId, message}
 * @param {Object} handlers {onEvent(event), onDone(), onError(err)} event 为已解析的 JSON 事件对象
 * @returns {Function} abort 函数（关闭连接）
 */
export function streamChat(payload, handlers) {
  const controller = new AbortController()
  const headers = {
    'Content-Type': 'application/json',
    'X-Guest-Eid': getGuestEid()
  }
  const token = store.state.token
  if (token) headers.Authorization = `Bearer ${token}`

  fetch(`${AGENT_BASE}/chat/stream`, {
    method: 'POST',
    headers,
    body: JSON.stringify(payload),
    signal: controller.signal
  }).then(async response => {
    if (!response.ok || !response.body) {
      throw new Error(`请求失败(${response.status})`)
    }
    const reader = response.body.getReader()
    const decoder = new TextDecoder('utf-8')
    let buffer = ''
    for (;;) {
      const { done, value } = await reader.read()
      if (done) break
      buffer += decoder.decode(value, { stream: true })
      // SSE 帧以空行分隔，逐帧解析 data: 行
      const frames = buffer.split('\n\n')
      buffer = frames.pop()
      for (const frame of frames) {
        for (const line of frame.split('\n')) {
          if (!line.startsWith('data:')) continue
          const data = line.slice(5).trim()
          if (data === '[DONE]') {
            handlers.onDone && handlers.onDone()
            return
          }
          try {
            handlers.onEvent && handlers.onEvent(JSON.parse(data))
          } catch (e) {
            // 忽略无法解析的帧
          }
        }
      }
    }
    handlers.onDone && handlers.onDone()
  }).catch(err => {
    if (err.name !== 'AbortError') {
      handlers.onError && handlers.onError(err)
    }
  })

  return () => controller.abort()
}
