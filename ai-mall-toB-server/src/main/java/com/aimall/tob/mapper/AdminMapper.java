package com.aimall.tob.mapper;

import com.aimall.tob.entity.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 管理员 Mapper
 */
@Mapper
public interface AdminMapper {

    Admin selectByUsername(@Param("username") String username);

    Admin selectById(@Param("id") Long id);
}
