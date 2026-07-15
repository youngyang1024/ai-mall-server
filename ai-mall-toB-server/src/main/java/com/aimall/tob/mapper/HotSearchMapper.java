package com.aimall.tob.mapper;

import com.aimall.common.entity.HotSearch;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface HotSearchMapper {
    List<HotSearch> selectAll();
    HotSearch selectById(@Param("id") Long id);
    int insert(HotSearch hotSearch);
    int update(HotSearch hotSearch);
    int deleteById(@Param("id") Long id);
}