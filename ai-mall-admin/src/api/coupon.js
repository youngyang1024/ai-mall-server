import request from '@/utils/request'

export function getCouponList() {
  return request({ url: '/admin/coupon/list', method: 'get' })
}

export function createCoupon(data) {
  return request({ url: '/admin/coupon', method: 'post', data })
}

export function updateCoupon(id, data) {
  return request({ url: `/admin/coupon/${id}`, method: 'put', data })
}

export function deleteCoupon(id) {
  return request({ url: `/admin/coupon/${id}`, method: 'delete' })
}
