package com.aimall.tob.mapper;

import com.aimall.common.entity.HotSearch;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * t_hot_search 表数据访问，提供热搜词列表查询、新增、更新、删除等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface HotSearchMapper {
    List<HotSearch> selectAll();
    HotSearch selectById(@Param("id") Long id);
    int insert(HotSearch hotSearch);
    int update(HotSearch hotSearch);
    int deleteById(@Param("id") Long id);
}