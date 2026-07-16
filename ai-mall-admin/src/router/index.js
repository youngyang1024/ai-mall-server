import Vue from 'vue'
import VueRouter from 'vue-router'
import store from '@/store'
import Layout from '@/views/layout/index.vue'
import Home from '@/views/Home.vue'
import Login from '@/views/login/index.vue'
import Category from '@/views/category/index.vue'
import ProductList from '@/views/product/list.vue'
import ProductEdit from '@/views/product/edit.vue'
import OrderList from '@/views/order/list.vue'
import BannerPage from '@/views/banner/index.vue'
import CouponPage from '@/views/coupon/index.vue'
import RefundPage from '@/views/refund/list.vue'
import HotSearchPage from '@/views/hot-search/index.vue'
import ServiceTicketPage from '@/views/service-ticket/index.vue'
import UserManagePage from '@/views/user-manage/index.vue'
import FaqPage from '@/views/faq/index.vue'
import ReviewPage from '@/views/review/index.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/login', name: 'Login', component: Login, meta: { public: true } },
  {
    path: '/',
    component: Layout,
    children: [
      { path: '', name: 'Home', component: Home },
      { path: 'category', name: 'Category', component: Category },
      { path: 'product', name: 'ProductList', component: ProductList },
      { path: 'product/add', name: 'ProductAdd', component: ProductEdit },
      { path: 'product/edit/:id', name: 'ProductEdit', component: ProductEdit },
      { path: 'order', name: 'OrderList', component: OrderList },
      { path: 'banner', name: 'Banner', component: BannerPage },
      { path: 'hot-search', name: 'HotSearch', component: HotSearchPage },
      { path: 'coupon', name: 'Coupon', component: CouponPage },
      { path: 'refund', name: 'Refund', component: RefundPage },
      { path: 'service-ticket', name: 'ServiceTicket', component: ServiceTicketPage },
      { path: 'user', name: 'UserManage', component: UserManagePage },
      { path: 'faq', name: 'Faq', component: FaqPage },
      { path: 'review', name: 'Review', component: ReviewPage }
    ]
  }
]

const router = new VueRouter({ mode: 'history', base: process.env.BASE_URL, routes })

router.beforeEach((to, from, next) => {
  if (to.meta.public) {
    if (store.state.token && to.path === '/login') next('/')
    else next()
    return
  }
  if (!store.state.token) next('/login')
  else next()
})

export default router
