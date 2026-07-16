import request from '@/utils/request'

export function getUserList(params) {
  return request({ url: '/admin/user/list', method: 'get', params })
}

export function getUserDetail(id) {
  return request({ url: `/admin/user/${id}/detail`, method: 'get' })
}

export function updateUserStatus(id, status) {
  return request({ url: `/admin/user/${id}/status`, method: 'put', data: { status } })
}
