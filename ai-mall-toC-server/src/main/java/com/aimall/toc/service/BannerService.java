package com.aimall.toc.service;

import com.aimall.common.entity.Banner;

import java.util.List;

/**
 * C端首页轮播图服务接口：查询已启用的 Banner 列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface BannerService {

    List<Banner> listEnabled();
}
