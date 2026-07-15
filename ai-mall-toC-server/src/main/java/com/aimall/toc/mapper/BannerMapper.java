package com.aimall.toc.mapper;

import com.aimall.common.entity.Banner;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BannerMapper {

    List<Banner> selectEnabled();
}
