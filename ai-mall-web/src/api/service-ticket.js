import request from '@/utils/request'

export function getServiceTicketOptions() {
  return request({
    url: '/api/service-ticket/options',
    method: 'get'
  })
}

export function createServiceTicket(data) {
  return request({
    url: '/api/service-ticket',
    method: 'post',
    data
  })
}

export function getMyServiceTicketList(params) {
  return request({
    url: '/api/service-ticket/list',
    method: 'get',
    params
  })
}

export function getServiceTicketDetail(ticketNo) {
  return request({
    url: `/api/service-ticket/${ticketNo}`,
    method: 'get'
  })
}

export function replyServiceTicket(ticketNo, data) {
  return request({
    url: `/api/service-ticket/${ticketNo}/reply`,
    method: 'post',
    data
  })
}

export function completeServiceTicket(ticketNo) {
  return request({
    url: `/api/service-ticket/${ticketNo}/complete`,
    method: 'put'
  })
}

export function uploadServiceTicketFile(file) {
  const formData = new FormData()
  formData.append('file', file)
  return request({
    url: '/api/service-ticket/upload',
    method: 'post',
    timeout: 120000,
    data: formData,
    headers: { 'Content-Type': 'multipart/form-data' }
  })
}
