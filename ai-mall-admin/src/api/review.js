import request from '@/utils/request'

export function getReviewList(params) {
  return request({ url: '/admin/review/list', method: 'get', params })
}

export function updateReviewStatus(id, status) {
  return request({ url: `/admin/review/${id}/status`, method: 'put', data: { status } })
}
