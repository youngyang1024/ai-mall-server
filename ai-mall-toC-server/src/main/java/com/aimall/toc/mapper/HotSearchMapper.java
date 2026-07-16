package com.aimall.toc.mapper;

import com.aimall.common.entity.HotSearch;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

/**
 * 热门搜索词表 Mapper：查询已启用的热搜词列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface HotSearchMapper {
    List<HotSearch> selectEnabled();
}