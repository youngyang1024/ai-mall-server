import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const userInfo = JSON.parse(localStorage.getItem('user_info') || 'null')

export default new Vuex.Store({
  state: {
    token: localStorage.getItem('user_token') || '',
    userInfo: userInfo
  },
  getters: {
    isLogin: state => !!state.token
  },
  mutations: {
    SET_TOKEN(state, token) {
      state.token = token
      if (token) localStorage.setItem('user_token', token)
      else localStorage.removeItem('user_token')
    },
    SET_USER_INFO(state, userInfo) {
      state.userInfo = userInfo
      if (userInfo) localStorage.setItem('user_info', JSON.stringify(userInfo))
      else localStorage.removeItem('user_info')
    }
  }
})
