package com.aimall.toc.mapper;

import com.aimall.common.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 用户表 Mapper：用户的注册插入、按用户名/ID 查询、资料更新及密码修改
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface UserMapper {

    User selectByUsername(@Param("username") String username);

    User selectById(@Param("id") Long id);

    int insert(User user);

    int update(User user);

    int updatePassword(@Param("id") Long id, @Param("password") String password);
}
