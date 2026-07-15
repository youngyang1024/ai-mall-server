package com.aimall.tob.mapper;

import com.aimall.common.entity.ServiceTicketAttachment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单附件 Mapper
 */
@Mapper
public interface ServiceTicketAttachmentMapper {

    int insert(ServiceTicketAttachment serviceTicketAttachment);

    List<ServiceTicketAttachment> selectByTicketId(Long ticketId);
}
