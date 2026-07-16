package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ServiceTicketDetailVO;
import com.aimall.common.vo.ServiceTicketListVO;
import com.aimall.tob.dto.ServiceTicketAdminReplyDTO;

/**
 * B端服务工单业务接口：定义工单分页查询（支持按状态、工单号、订单号筛选）、详情查询、管理员回复、状态变更能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface ServiceTicketService {

    PageResult<ServiceTicketListVO> list(Integer status, String ticketNo, String orderNo, int pageNum, int pageSize);

    ServiceTicketDetailVO detail(Long id);

    void reply(Long id, ServiceTicketAdminReplyDTO dto);

    void updateStatus(Long id, Integer status);
}
