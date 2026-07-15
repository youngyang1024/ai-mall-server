package com.aimall.tob.service;

import com.aimall.common.entity.Banner;
import com.aimall.tob.dto.BannerDTO;

import java.util.List;

public interface BannerService {

    List<Banner> list();

    void create(BannerDTO dto);

    void update(BannerDTO dto);

    void delete(Long id);
}
