package com.aimall.tob.mapper;

import com.aimall.common.entity.ServiceTicket;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 服务工单主表 Mapper
 */
@Mapper
public interface ServiceTicketMapper {

    List<ServiceTicket> selectList(@Param("status") Integer status,
                                   @Param("ticketNo") String ticketNo,
                                   @Param("orderNo") String orderNo);

    ServiceTicket selectById(@Param("id") Long id);

    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    int updateStatusAndLastReply(@Param("id") Long id,
                                 @Param("status") Integer status,
                                 @Param("lastReplyUserType") Integer lastReplyUserType);
}
