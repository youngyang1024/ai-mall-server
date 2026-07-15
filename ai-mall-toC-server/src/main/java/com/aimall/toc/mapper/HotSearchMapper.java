package com.aimall.toc.mapper;

import com.aimall.common.entity.HotSearch;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface HotSearchMapper {
    List<HotSearch> selectEnabled();
}