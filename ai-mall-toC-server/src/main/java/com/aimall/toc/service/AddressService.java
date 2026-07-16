package com.aimall.toc.service;

import com.aimall.common.entity.UserAddress;
import com.aimall.toc.dto.AddressDTO;

import java.util.List;

/**
 * C端收货地址服务接口：地址列表/新增/修改/删除/设置默认地址
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface AddressService {
    List<UserAddress> list(Long userId);
    void create(Long userId, AddressDTO dto);
    void update(Long userId, Long addressId, AddressDTO dto);
    void delete(Long userId, Long addressId);
    void setDefault(Long userId, Long addressId);
}
