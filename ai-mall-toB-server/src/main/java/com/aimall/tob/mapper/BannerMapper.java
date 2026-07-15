package com.aimall.tob.mapper;

import com.aimall.common.entity.Banner;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BannerMapper {

    List<Banner> selectAll();

    Banner selectById(@Param("id") Long id);

    int insert(Banner banner);

    int update(Banner banner);

    int deleteById(@Param("id") Long id);
}
