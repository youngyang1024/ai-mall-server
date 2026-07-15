import request from '@/utils/request'

export function getAddressList() {
  return request({ url: '/api/address/list', method: 'get' })
}

export function createAddress(data) {
  return request({ url: '/api/address', method: 'post', data })
}

export function updateAddress(id, data) {
  return request({ url: `/api/address/${id}`, method: 'put', data })
}

export function deleteAddress(id) {
  return request({ url: `/api/address/${id}`, method: 'delete' })
}

export function setDefaultAddress(id) {
  return request({ url: `/api/address/${id}/default`, method: 'put' })
}
