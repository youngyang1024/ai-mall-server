import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.use(ElementUI)
Vue.config.productionTip = false

// 接口错误已在 request 拦截器中 Toast，避免 dev-server 全屏报错遮罩
window.addEventListener('unhandledrejection', (event) => {
  if (event.reason && event.reason.message) {
    event.preventDefault()
  }
})

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
