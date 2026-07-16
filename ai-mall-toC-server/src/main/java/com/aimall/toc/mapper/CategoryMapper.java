package com.aimall.toc.mapper;

import com.aimall.common.entity.Category;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 商品分类表 Mapper：查询已启用的分类列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface CategoryMapper {

    List<Category> selectEnabled();
}
