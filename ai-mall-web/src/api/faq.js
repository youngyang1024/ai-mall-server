import request from '@/utils/request'

export function getFaqCategoryList() {
  return request({
    url: '/api/faq/category/list',
    method: 'get'
  })
}

export function getFaqArticleList(params) {
  return request({
    url: '/api/faq/article/list',
    method: 'get',
    params
  })
}
