package com.aimall.tob.mapper;

import com.aimall.common.entity.Category;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CategoryMapper {

    List<Category> selectAll();

    Category selectById(@Param("id") Long id);

    int insert(Category category);

    int update(Category category);

    int deleteById(@Param("id") Long id);

    int countByParentId(@Param("parentId") Long parentId);

    int countSpuByCategoryId(@Param("categoryId") Long categoryId);
}
