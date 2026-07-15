import request from '@/utils/request'

export function getBannerList() {
  return request({ url: '/api/banner/list', method: 'get' })
}
