package com.aimall.toc.service.impl;

import com.aimall.common.entity.Banner;
import com.aimall.toc.mapper.BannerMapper;
import com.aimall.toc.service.BannerService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * C端首页 Banner 服务实现：查询已启用的轮播图列表
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
    public List<Banner> listEnabled() {
        return bannerMapper.selectEnabled();
    }
}
