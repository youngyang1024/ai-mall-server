import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '@/store'
import Home from '@/views/home/index.vue'
import Category from '@/views/category/index.vue'
import ProductList from '@/views/product/list.vue'
import ProductDetail from '@/views/product/detail.vue'
import Login from '@/views/login/index.vue'
import Register from '@/views/register/index.vue'
import UserCenter from '@/views/user/index.vue'
import AddressPage from '@/views/user/address.vue'
import UserReviewPage from '@/views/user/review.vue'
import UserFavoritePage from '@/views/user/favorite.vue'
import CartPage from '@/views/cart/index.vue'
import CheckoutPage from '@/views/order/checkout.vue'
import PayPage from '@/views/order/pay.vue'
import OrderListPage from '@/views/order/list.vue'
import OrderDetailPage from '@/views/order/detail.vue'
import CouponCenterPage from '@/views/coupon/center.vue'
import RefundListPage from '@/views/refund/list.vue'
import RefundDetailPage from '@/views/refund/detail.vue'
import HelpCenterPage from '@/views/help/index.vue'
import ServiceCenterPage from '@/views/service-center/index.vue'
import ServiceTicketListPage from '@/views/service-ticket/list.vue'
import ServiceTicketDetailPage from '@/views/service-ticket/detail.vue'

import CouponPage from '@/views/coupon/index.vue'

Vue.use(VueRouter)

import UserLayout from '@/views/user/layout.vue'

// Vue Router 3.x：重复跳转当前路由会抛 NavigationDuplicated，统一静默处理
const originalPush = VueRouter.prototype.push
VueRouter.prototype.push = function push(location, onResolve, onReject) {
  if (onResolve || onReject) {
    return originalPush.call(this, location, onResolve, onReject)
  }
  return originalPush.call(this, location).catch(err => {
    if (err.name !== 'NavigationDuplicated') {
      return Promise.reject(err)
    }
  })
}

const originalReplace = VueRouter.prototype.replace
VueRouter.prototype.replace = function replace(location, onResolve, onReject) {
  if (onResolve || onReject) {
    return originalReplace.call(this, location, onResolve, onReject)
  }
  return originalReplace.call(this, location).catch(err => {
    if (err.name !== 'NavigationDuplicated') {
      return Promise.reject(err)
    }
  })
}

const routes = [
  { path: '/', name: 'Home', component: Home, meta: { public: true, tabbar: true } },
  { path: '/category', name: 'Category', component: Category, meta: { public: true, tabbar: true } },
  { path: '/product', name: 'ProductList', component: ProductList, meta: { public: true } },
  { path: '/product/:id', name: 'ProductDetail', component: ProductDetail, meta: { public: true } },
  { path: '/login', name: 'Login', component: Login, meta: { public: true } },
  { path: '/register', name: 'Register', component: Register, meta: { public: true } },
  { path: '/cart', name: 'Cart', component: CartPage, meta: { tabbar: true } },
  { path: '/order/checkout', name: 'Checkout', component: CheckoutPage },
  { path: '/order/pay', name: 'Pay', component: PayPage },
  
  { path: '/coupon-center', name: 'CouponCenter', component: CouponCenterPage, meta: { public: true } },
  { path: '/help', name: 'HelpCenter', component: HelpCenterPage, meta: { public: true } },
  { path: '/service-center', name: 'ServiceCenter', component: ServiceCenterPage, meta: { public: true, tabbar: true } },
  
  // 会员中心及附属页面，使用 UserLayout 嵌套路由
  {
    path: '/',
    component: UserLayout,
    children: [
      { path: 'user', name: 'User', component: UserCenter, meta: { public: true, tabbar: true } },
      { path: 'user/address', name: 'Address', component: AddressPage },
      { path: 'user/review', name: 'UserReview', component: UserReviewPage },
      { path: 'user/favorite', name: 'UserFavorite', component: UserFavoritePage },
      { path: 'coupon', name: 'Coupon', component: CouponPage },
      { path: 'refund', name: 'RefundList', component: RefundListPage },
      { path: 'refund/:id', name: 'RefundDetail', component: RefundDetailPage },
      { path: 'service-ticket', name: 'ServiceTicketList', component: ServiceTicketListPage },
      { path: 'service-ticket/:ticketNo', name: 'ServiceTicketDetail', component: ServiceTicketDetailPage },
      { path: 'order', name: 'OrderList', component: OrderListPage },
      { path: 'order/:orderNo', name: 'OrderDetail', component: OrderDetailPage }
    ]
  }
]

const router = new VueRouter({ mode: 'history', base: process.env.BASE_URL, routes })

router.beforeEach((to, from, next) => {
  if (to.meta.public || store.getters.isLogin) {
    next()
  } else {
    next({ path: '/login', query: { redirect: to.fullPath } })
  }
})

export default router
