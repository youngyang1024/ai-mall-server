import request from '@/utils/request'

export function getHotSearchList() {
  return request({ url: '/admin/hot-search/list', method: 'get' })
}

export function createHotSearch(data) {
  return request({ url: '/admin/hot-search', method: 'post', data })
}

export function updateHotSearch(data) {
  return request({ url: '/admin/hot-search', method: 'put', data })
}

export function deleteHotSearch(id) {
  return request({ url: `/admin/hot-search/${id}`, method: 'delete' })
}
