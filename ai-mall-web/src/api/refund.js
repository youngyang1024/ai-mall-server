import request from '@/utils/request'

export function applyRefund(data) {
  return request({ url: '/api/refund/apply', method: 'post', data })
}

export function getRefundList(params) {
  return request({ url: '/api/refund/list', method: 'get', params })
}

export function getRefundDetail(id) {
  return request({ url: `/api/refund/${id}`, method: 'get' })
}
