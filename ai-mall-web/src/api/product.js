import request from '@/utils/request'

export function getCategoryTree() {
  return request({ url: '/api/category/tree', method: 'get' })
}

export function getProductList(params) {
  return request({ url: '/api/product/list', method: 'get', params })
}

export function searchProduct(params) {
  return request({ url: '/api/product/search', method: 'get', params })
}

export function getProductDetail(spuId) {
  return request({ url: `/api/product/${spuId}`, method: 'get' })
}

export function getHotRecommend(limit = 10) {
  return request({ url: '/api/product/recommend/hot', method: 'get', params: { limit } })
}

export function getForYouRecommend(spuId, limit = 8) {
  return request({ url: '/api/product/recommend/for-you', method: 'get', params: { spuId, limit } })
}

export function getViewedAlsoRecommend(keyword, limit = 8) {
  return request({ url: '/api/product/recommend/viewed-also', method: 'get', params: { keyword, limit } })
}

export function getBoughtAlsoRecommend(categoryId, limit = 8) {
  return request({ url: '/api/product/recommend/bought-also', method: 'get', params: { categoryId, limit } })
}

export function getHotSearchList() {
  return request({ url: '/api/hot-search/list', method: 'get' })
}
