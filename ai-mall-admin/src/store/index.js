import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const userInfo = JSON.parse(localStorage.getItem('admin_user_info') || 'null')

export default new Vuex.Store({
  state: {
    token: localStorage.getItem('admin_token') || '',
    userInfo: userInfo
  },
  mutations: {
    SET_TOKEN(state, token) {
      state.token = token
      if (token) {
        localStorage.setItem('admin_token', token)
      } else {
        localStorage.removeItem('admin_token')
      }
    },
    SET_USER_INFO(state, userInfo) {
      state.userInfo = userInfo
      if (userInfo) {
        localStorage.setItem('admin_user_info', JSON.stringify(userInfo))
      } else {
        localStorage.removeItem('admin_user_info')
      }
    }
  },
  actions: {},
  modules: {}
})
