package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceTicketAttachment;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单附件表 Mapper：附件的新增及按工单查询
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface ServiceTicketAttachmentMapper {

    int insert(ServiceTicketAttachment serviceTicketAttachment);

    List<ServiceTicketAttachment> selectByTicketId(Long ticketId);
}
