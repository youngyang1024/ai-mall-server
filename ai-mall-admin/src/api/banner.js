import request from '@/utils/request'

export function getBannerList() {
  return request({ url: '/admin/banner/list', method: 'get' })
}

export function createBanner(data) {
  return request({ url: '/admin/banner', method: 'post', data })
}

export function updateBanner(id, data) {
  return request({ url: `/admin/banner/${id}`, method: 'put', data })
}

export function deleteBanner(id) {
  return request({ url: `/admin/banner/${id}`, method: 'delete' })
}
