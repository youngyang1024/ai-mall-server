package com.aimall.tob.mapper;

import com.aimall.common.entity.ServiceTicket;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 服务工单主表 t_service_ticket 表数据访问，提供工单条件列表查询、状态更新、状态及最后回复方更新等操作
 *
 * @author
 * Created by Yang on 2026/07/16
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
