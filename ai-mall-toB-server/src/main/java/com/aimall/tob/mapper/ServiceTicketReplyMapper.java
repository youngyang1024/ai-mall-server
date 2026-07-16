package com.aimall.tob.mapper;

import com.aimall.common.entity.ServiceTicketReply;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单回复 t_service_ticket_reply 表数据访问，提供回复新增、按工单 ID 查询等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface ServiceTicketReplyMapper {

    int insert(ServiceTicketReply serviceTicketReply);

    List<ServiceTicketReply> selectByTicketId(Long ticketId);
}
