package com.aimall.tob.mapper;

import com.aimall.common.entity.Refund;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface RefundMapper {

    List<Refund> selectList(@Param("status") Integer status);

    Refund selectById(@Param("id") Long id);

    int updateApproved(@Param("id") Long id);

    int updateRejected(@Param("id") Long id, @Param("rejectReason") String rejectReason);
}
