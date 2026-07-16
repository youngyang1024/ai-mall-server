package com.aimall.tob.mapper;

import com.aimall.common.entity.ServiceTicketAttachment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单附件 t_service_ticket_attachment 表数据访问，提供附件新增、按工单 ID 查询等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface ServiceTicketAttachmentMapper {

    int insert(ServiceTicketAttachment serviceTicketAttachment);

    List<ServiceTicketAttachment> selectByTicketId(Long ticketId);
}
