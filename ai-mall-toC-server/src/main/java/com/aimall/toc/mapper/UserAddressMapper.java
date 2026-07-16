package com.aimall.toc.mapper;

import com.aimall.common.entity.UserAddress;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户收货地址表 Mapper：地址的增删改查及默认地址的清除与设置
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface UserAddressMapper {

    List<UserAddress> selectByUserId(@Param("userId") Long userId);

    UserAddress selectById(@Param("id") Long id);

    int insert(UserAddress address);

    int update(UserAddress address);

    int deleteById(@Param("id") Long id);

    int clearDefault(@Param("userId") Long userId);

    int setDefault(@Param("id") Long id, @Param("userId") Long userId);
}
