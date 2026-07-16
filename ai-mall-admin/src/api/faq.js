import request from '@/utils/request'

// 分类
export function getFaqCategoryList(params) {
  return request({ url: '/admin/faq/category/list', method: 'get', params })
}

export function saveFaqCategory(data) {
  return request({ url: '/admin/faq/category/save', method: 'post', data })
}

export function updateFaqCategory(data) {
  return request({ url: '/admin/faq/category/update', method: 'post', data })
}

export function deleteFaqCategory(id) {
  return request({ url: `/admin/faq/category/delete/${id}`, method: 'post' })
}

// 文章
export function getFaqArticleList(params) {
  return request({ url: '/admin/faq/article/list', method: 'get', params })
}

export function saveFaqArticle(data) {
  return request({ url: '/admin/faq/article/save', method: 'post', data })
}

export function updateFaqArticle(data) {
  return request({ url: '/admin/faq/article/update', method: 'post', data })
}

export function deleteFaqArticle(id) {
  return request({ url: `/admin/faq/article/delete/${id}`, method: 'post' })
}
