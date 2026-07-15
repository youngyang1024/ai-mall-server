import request from '@/utils/request'

export function getProductList(params) {
  return request({ url: '/admin/product/list', method: 'get', params })
}

export function getProductDetail(spuId) {
  return request({ url: `/admin/product/${spuId}`, method: 'get' })
}

export function createProduct(data) {
  return request({ url: '/admin/product', method: 'post', data })
}

export function updateProduct(spuId, data) {
  return request({ url: `/admin/product/${spuId}`, method: 'put', data })
}

export function updateProductStatus(spuId, status) {
  return request({ url: `/admin/product/${spuId}/status`, method: 'put', params: { status } })
}
