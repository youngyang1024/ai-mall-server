package com.aimall.tob.service;

import com.aimall.common.entity.Banner;
import com.aimall.tob.dto.BannerDTO;

import java.util.List;

/**
 * B端Banner管理业务接口：定义Banner列表查询、新增、更新、删除能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface BannerService {

    List<Banner> list();

    void create(BannerDTO dto);

    void update(BannerDTO dto);

    void delete(Long id);
}
