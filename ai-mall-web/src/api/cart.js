import request from '@/utils/request'

export function getCartList() {
  return request({ url: '/api/cart/list', method: 'get' })
}

export function addToCart(data) {
  return request({ url: '/api/cart/add', method: 'post', data })
}

export function updateCart(data) {
  return request({ url: '/api/cart/update', method: 'put', data })
}

export function deleteCartItem(id) {
  return request({ url: `/api/cart/${id}`, method: 'delete' })
}

export function clearCart() {
  return request({ url: '/api/cart/clear', method: 'delete' })
}
