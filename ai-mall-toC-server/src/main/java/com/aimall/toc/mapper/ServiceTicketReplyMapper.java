package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceTicketReply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单回复表 Mapper：回复的新增及按工单查询
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface ServiceTicketReplyMapper {

    int insert(ServiceTicketReply serviceTicketReply);

    List<ServiceTicketReply> selectByTicketId(Long ticketId);
}
