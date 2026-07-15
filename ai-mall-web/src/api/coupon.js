import request from '@/utils/request'

export function getAvailableCoupons() {
  return request({ url: '/api/coupon/available', method: 'get' })
}

export function receiveCoupon(couponId) {
  return request({ url: `/api/coupon/${couponId}/receive`, method: 'post' })
}

export function getMyCoupons(params) {
  return request({ url: '/api/coupon/my', method: 'get', params })
}

export function getUsableCoupons(orderAmount) {
  return request({ url: '/api/coupon/usable', method: 'get', params: { orderAmount } })
}
