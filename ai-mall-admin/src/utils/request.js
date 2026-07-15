import axios from 'axios'
import { Message } from 'element-ui'
import store from '@/store'
import router from '@/router'

const service = axios.create({
  baseURL: '/',
  timeout: 15000
})

function resolveErrorMessage(error) {
  if (error.response) {
    const data = error.response.data
    if (data && typeof data === 'object' && data.message) {
      return data.message
    }
    if (typeof data === 'string' && data.trim()) {
      return data.slice(0, 200)
    }
    return `请求失败(${error.response.status})`
  }
  return error.message || '网络异常'
}

service.interceptors.request.use(
  config => {
    const token = store.state.token
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  error => Promise.reject(error)
)

service.interceptors.response.use(
  response => {
    const res = response.data
    if (res.code !== 200) {
      const message = res.message || '请求失败'
      Message.error(message)
      if (res.code === 401) {
        store.commit('SET_TOKEN', '')
        router.push('/login')
      }
      return Promise.reject(new Error(message))
    }
    return res
  },
  error => {
    const message = resolveErrorMessage(error)
    Message.error(message)
    return Promise.reject(new Error(message))
  }
)

export default service
