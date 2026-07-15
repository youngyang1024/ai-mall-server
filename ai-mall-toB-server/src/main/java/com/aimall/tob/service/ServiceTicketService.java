package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ServiceTicketDetailVO;
import com.aimall.common.vo.ServiceTicketListVO;
import com.aimall.tob.dto.ServiceTicketAdminReplyDTO;

/**
 * B端服务工单 Service
 */
public interface ServiceTicketService {

    PageResult<ServiceTicketListVO> list(Integer status, String ticketNo, String orderNo, int pageNum, int pageSize);

    ServiceTicketDetailVO detail(Long id);

    void reply(Long id, ServiceTicketAdminReplyDTO dto);

    void updateStatus(Long id, Integer status);
}
