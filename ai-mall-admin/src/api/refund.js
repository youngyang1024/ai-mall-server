import request from '@/utils/request'

export function getRefundList(params) {
  return request({ url: '/admin/refund/list', method: 'get', params })
}

export function getRefundDetail(id) {
  return request({ url: `/admin/refund/${id}`, method: 'get' })
}

export function approveRefund(id) {
  return request({ url: `/admin/refund/${id}/approve`, method: 'put' })
}

export function rejectRefund(id, data) {
  return request({ url: `/admin/refund/${id}/reject`, method: 'put', data })
}
