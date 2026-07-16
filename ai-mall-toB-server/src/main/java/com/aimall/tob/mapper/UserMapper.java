package com.aimall.tob.mapper;

import com.aimall.common.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

/**
 * t_user 表数据访问（含 t_order、t_refund、t_service_ticket 关联统计），提供用户条件列表查询、状态更新及订单数、消费金额、退款数、工单数统计等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface UserMapper {

    List<User> selectList(@Param("username") String username, @Param("phone") String phone,
                          @Param("status") Integer status);

    User selectById(@Param("id") Long id);

    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    long countOrder(@Param("userId") Long userId);

    BigDecimal sumPayAmount(@Param("userId") Long userId);

    long countRefund(@Param("userId") Long userId);

    long countServiceTicket(@Param("userId") Long userId);
}
