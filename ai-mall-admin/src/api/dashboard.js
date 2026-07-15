import request from '@/utils/request'

export function getDashboardOverview() {
  return request({ url: '/admin/dashboard/overview', method: 'get' })
}

export function getSalesTrend(period) {
  return request({ url: '/admin/dashboard/sales-trend', method: 'get', params: { period } })
}

export function getProductRank() {
  return request({ url: '/admin/dashboard/product-rank', method: 'get' })
}

export function getOrderStatus() {
  return request({ url: '/admin/dashboard/order-status', method: 'get' })
}
