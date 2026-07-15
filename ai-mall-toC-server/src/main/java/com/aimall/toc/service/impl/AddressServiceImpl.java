package com.aimall.toc.service.impl;

import com.aimall.common.entity.UserAddress;
import com.aimall.common.exception.BusinessException;
import com.aimall.toc.dto.AddressDTO;
import com.aimall.toc.mapper.UserAddressMapper;
import com.aimall.toc.service.AddressService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {

    private final UserAddressMapper userAddressMapper;

    public AddressServiceImpl(UserAddressMapper userAddressMapper) {
        this.userAddressMapper = userAddressMapper;
    }

    @Override
    public List<UserAddress> list(Long userId) {
        return userAddressMapper.selectByUserId(userId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void create(Long userId, AddressDTO dto) {
        UserAddress address = toEntity(userId, dto);
        if (address.getIsDefault() != null && address.getIsDefault() == 1) {
            userAddressMapper.clearDefault(userId);
        }
        userAddressMapper.insert(address);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(Long userId, Long addressId, AddressDTO dto) {
        UserAddress exist = userAddressMapper.selectById(addressId);
        if (exist == null || !exist.getUserId().equals(userId)) {
            throw new BusinessException("地址不存在");
        }
        UserAddress address = toEntity(userId, dto);
        address.setId(addressId);
        if (address.getIsDefault() != null && address.getIsDefault() == 1) {
            userAddressMapper.clearDefault(userId);
        }
        userAddressMapper.update(address);
    }

    @Override
    public void delete(Long userId, Long addressId) {
        UserAddress exist = userAddressMapper.selectById(addressId);
        if (exist == null || !exist.getUserId().equals(userId)) {
            throw new BusinessException("地址不存在");
        }
        userAddressMapper.deleteById(addressId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void setDefault(Long userId, Long addressId) {
        UserAddress exist = userAddressMapper.selectById(addressId);
        if (exist == null || !exist.getUserId().equals(userId)) {
            throw new BusinessException("地址不存在");
        }
        userAddressMapper.clearDefault(userId);
        userAddressMapper.setDefault(addressId, userId);
    }

    private UserAddress toEntity(Long userId, AddressDTO dto) {
        UserAddress address = new UserAddress();
        address.setUserId(userId);
        address.setReceiverName(dto.getReceiverName());
        address.setReceiverPhone(dto.getReceiverPhone());
        address.setProvince(dto.getProvince());
        address.setCity(dto.getCity());
        address.setDistrict(dto.getDistrict());
        address.setDetail(dto.getDetail());
        address.setIsDefault(dto.getIsDefault() != null ? dto.getIsDefault() : 0);
        return address;
    }
}
