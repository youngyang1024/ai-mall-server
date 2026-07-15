import Vue from 'vue'
import Vant from 'vant'
import 'vant/lib/index.css'
import '@/styles/responsive.css'
import '@/styles/shopify.css'
import App from './App.vue'
import router from './router'
import store from './store'
import responsiveMixin from '@/mixins/responsive'
import PageShell from '@/components/layout/PageShell.vue'
import ProductTile from '@/components/ProductTile.vue'

Vue.use(Vant)
Vue.mixin(responsiveMixin)
Vue.component('PageShell', PageShell)
Vue.component('ProductTile', ProductTile)
Vue.config.productionTip = false

// 接口错误已在 request 拦截器中 Toast；路由重复跳转等已知异常不弹全屏遮罩
window.addEventListener('unhandledrejection', (event) => {
  const reason = event.reason
  if (!reason) return
  if (reason.name === 'NavigationDuplicated') {
    event.preventDefault()
    return
  }
  if (reason.message) {
    event.preventDefault()
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
