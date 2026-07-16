package com.aimall.tob.mapper;

import com.aimall.common.entity.Category;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_category 表数据访问（含 t_spu 关联商品计数），提供商品分类列表查询、新增、更新、删除及子分类/关联商品统计等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
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
