import request from '@/utils/request'

export function getUserInfo() {
  return request({ url: '/api/user/info', method: 'get' })
}

export function updateUserInfo(data) {
  return request({ url: '/api/user/info', method: 'put', data })
}

export function updatePassword(data) {
  return request({ url: '/api/user/password', method: 'put', data })
}
