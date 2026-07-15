import request from '@/utils/request'

export function createOrder(data) {
  return request({ url: '/api/order/create', method: 'post', data })
}

export function payOrder(orderNo) {
  return request({ url: `/api/order/${orderNo}/pay`, method: 'post' })
}

export function cancelOrder(orderNo) {
  return request({ url: `/api/order/${orderNo}/cancel`, method: 'post' })
}

export function confirmOrder(orderNo) {
  return request({ url: `/api/order/${orderNo}/confirm`, method: 'put' })
}

export function getOrderList(params) {
  return request({ url: '/api/order/list', method: 'get', params })
}

export function getOrderDetail(orderNo) {
  return request({ url: `/api/order/${orderNo}`, method: 'get' })
}
