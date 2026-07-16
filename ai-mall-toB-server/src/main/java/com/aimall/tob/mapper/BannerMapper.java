package com.aimall.tob.mapper;

import com.aimall.common.entity.Banner;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_banner 表数据访问，提供 Banner 列表查询、新增、更新、删除等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface BannerMapper {

    List<Banner> selectAll();

    Banner selectById(@Param("id") Long id);

    int insert(Banner banner);

    int update(Banner banner);

    int deleteById(@Param("id") Long id);
}
