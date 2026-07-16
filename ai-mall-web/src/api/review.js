import request from '@/utils/request'

export function submitReview(data) {
  return request({ url: '/api/review', method: 'post', data })
}

export function getReviewList(params) {
  return request({ url: '/api/review/list', method: 'get', params })
}

export function getReviewSummary(spuId) {
  return request({ url: '/api/review/summary', method: 'get', params: { spuId } })
}

export function getPendingReviews(params) {
  return request({ url: '/api/review/pending', method: 'get', params })
}

export function getMyReviews(params) {
  return request({ url: '/api/review/my', method: 'get', params })
}
