package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceTicket;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 服务工单主表 Mapper
 */
@Mapper
public interface ServiceTicketMapper {

    int insert(ServiceTicket serviceTicket);

    ServiceTicket selectByTicketNoAndUserId(@Param("ticketNo") String ticketNo, @Param("userId") Long userId);

    List<ServiceTicket> selectByUserId(@Param("userId") Long userId);

    int updateStatusAndLastReply(@Param("id") Long id,
                                 @Param("status") Integer status,
                                 @Param("lastReplyUserType") Integer lastReplyUserType);

    int updateStatusByUser(@Param("id") Long id, @Param("userId") Long userId, @Param("status") Integer status);
}
