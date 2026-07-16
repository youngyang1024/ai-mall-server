package com.aimall.toc.mapper;

import com.aimall.common.entity.Banner;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 首页轮播图表 Mapper：查询已启用的 Banner 列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface BannerMapper {

    List<Banner> selectEnabled();
}
