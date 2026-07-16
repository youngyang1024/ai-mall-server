package com.aimall.tob.mapper;

import com.aimall.common.entity.Refund;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_refund 表数据访问，提供退款单列表查询、审批通过/驳回状态更新等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface RefundMapper {

    List<Refund> selectList(@Param("status") Integer status);

    Refund selectById(@Param("id") Long id);

    int updateApproved(@Param("id") Long id);

    int updateRejected(@Param("id") Long id, @Param("rejectReason") String rejectReason);
}
