package com.aimall.tob.service.impl;

import com.aimall.common.entity.Banner;
import com.aimall.common.exception.BusinessException;
import com.aimall.tob.dto.BannerDTO;
import com.aimall.tob.mapper.BannerMapper;
import com.aimall.tob.service.BannerService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * B端轮播图管理服务实现，基于 BannerMapper 提供列表与增删改，新增时 sort 默认 0、status 默认启用，更新/删除前校验记录存在
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class BannerServiceImpl implements BannerService {

    private final BannerMapper bannerMapper;

    public BannerServiceImpl(BannerMapper bannerMapper) {
        this.bannerMapper = bannerMapper;
    }

    @Override
    public List<Banner> list() {
        return bannerMapper.selectAll();
    }

    @Override
    public void create(BannerDTO dto) {
        Banner banner = toEntity(dto);
        if (banner.getSort() == null) {
            banner.setSort(0);
        }
        if (banner.getStatus() == null) {
            banner.setStatus(1);
        }
        bannerMapper.insert(banner);
    }

    @Override
    public void update(BannerDTO dto) {
        if (dto.getId() == null) {
            throw new BusinessException("轮播图ID不能为空");
        }
        Banner exist = bannerMapper.selectById(dto.getId());
        if (exist == null) {
            throw new BusinessException("轮播图不存在");
        }
        bannerMapper.update(toEntity(dto));
    }

    @Override
    public void delete(Long id) {
        Banner exist = bannerMapper.selectById(id);
        if (exist == null) {
            throw new BusinessException("轮播图不存在");
        }
        bannerMapper.deleteById(id);
    }

    private Banner toEntity(BannerDTO dto) {
        Banner banner = new Banner();
        banner.setId(dto.getId());
        banner.setTitle(dto.getTitle());
        banner.setImageUrl(dto.getImageUrl());
        banner.setLinkUrl(dto.getLinkUrl());
        banner.setSort(dto.getSort());
        banner.setStatus(dto.getStatus());
        return banner;
    }
}
