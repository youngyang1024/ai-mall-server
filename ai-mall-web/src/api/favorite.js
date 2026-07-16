import request from '@/utils/request'

export function addFavorite(spuId) {
  return request({ url: `/api/favorite/${spuId}`, method: 'post' })
}

export function removeFavorite(spuId) {
  return request({ url: `/api/favorite/${spuId}`, method: 'delete' })
}

export function getFavoriteList(params) {
  return request({ url: '/api/favorite/list', method: 'get', params })
}

export function checkFavorite(spuId) {
  return request({ url: '/api/favorite/check', method: 'get', params: { spuId } })
}

export function getFavoriteCount() {
  return request({ url: '/api/favorite/count', method: 'get' })
}
