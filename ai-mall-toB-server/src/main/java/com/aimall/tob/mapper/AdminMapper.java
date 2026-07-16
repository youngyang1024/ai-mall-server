package com.aimall.tob.mapper;

import com.aimall.tob.entity.Admin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 管理员 t_admin 表数据访问，提供按用户名、按主键 ID 查询管理员等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface AdminMapper {

    Admin selectByUsername(@Param("username") String username);

    Admin selectById(@Param("id") Long id);
}
