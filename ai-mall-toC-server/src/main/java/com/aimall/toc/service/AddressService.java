package com.aimall.toc.service;

import com.aimall.common.entity.UserAddress;
import com.aimall.toc.dto.AddressDTO;

import java.util.List;

public interface AddressService {
    List<UserAddress> list(Long userId);
    void create(Long userId, AddressDTO dto);
    void update(Long userId, Long addressId, AddressDTO dto);
    void delete(Long userId, Long addressId);
    void setDefault(Long userId, Long addressId);
}
