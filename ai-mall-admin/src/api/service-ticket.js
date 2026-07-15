import request from '@/utils/request'

export function getServiceTicketList(params) {
  return request({
    url: '/admin/service-ticket/list',
    method: 'get',
    params
  })
}

export function getServiceTicketDetail(id) {
  return request({
    url: `/admin/service-ticket/${id}`,
    method: 'get'
  })
}

export function replyServiceTicket(id, data) {
  return request({
    url: `/admin/service-ticket/${id}/reply`,
    method: 'post',
    data
  })
}

export function updateServiceTicketStatus(id, data) {
  return request({
    url: `/admin/service-ticket/${id}/status`,
    method: 'put',
    data
  })
}

export function uploadServiceTicketFile(file) {
  const formData = new FormData()
  formData.append('file', file)
  return request({
    url: '/admin/service-ticket/upload',
    method: 'post',
    timeout: 120000,
    data: formData,
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}
