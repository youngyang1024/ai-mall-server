package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceTicketReply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单回复 Mapper
 */
@Mapper
public interface ServiceTicketReplyMapper {

    int insert(ServiceTicketReply serviceTicketReply);

    List<ServiceTicketReply> selectByTicketId(Long ticketId);
}
