package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceTicket;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 服务工单主表 Mapper：工单的创建、按用户/工单号查询及状态与最后回复方更新
 *
 * @author
 * Created by Yang on 2026/07/16
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
