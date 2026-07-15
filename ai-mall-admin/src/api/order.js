import request from '@/utils/request'

export function getOrderList(params) {
  return request({ url: '/admin/order/list', method: 'get', params })
}

export function getOrderDetail(orderNo) {
  return request({ url: `/admin/order/${orderNo}`, method: 'get' })
}

export function shipOrder(orderNo, data) {
  return request({ url: `/admin/order/${orderNo}/ship`, method: 'put', data })
}
