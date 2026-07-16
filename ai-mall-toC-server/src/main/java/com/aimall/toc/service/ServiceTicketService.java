package com.aimall.toc.service;

import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ServiceCategoryOptionVO;
import com.aimall.common.vo.ServiceTicketDetailVO;
import com.aimall.common.vo.ServiceTicketListVO;
import com.aimall.toc.dto.ServiceTicketCreateDTO;
import com.aimall.toc.dto.ServiceTicketReplyDTO;

import java.util.List;

/**
 * C端服务工单服务接口：工单分类选项/创建工单/我的工单列表/工单详情/回复/完结
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface ServiceTicketService {

    List<ServiceCategoryOptionVO> getOptions();

    String create(Long userId, ServiceTicketCreateDTO dto);

    PageResult<ServiceTicketListVO> listByUser(Long userId, int pageNum, int pageSize);

    ServiceTicketDetailVO detail(Long userId, String ticketNo);

    void reply(Long userId, String ticketNo, ServiceTicketReplyDTO dto);

    void complete(Long userId, String ticketNo);
}
