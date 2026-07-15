package com.aimall.toc.mapper;

import com.aimall.common.entity.Category;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CategoryMapper {

    List<Category> selectEnabled();
}
