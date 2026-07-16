package com.aimall.tob.service;

import com.aimall.common.entity.Category;
import com.aimall.tob.dto.CategoryDTO;

import java.util.List;

/**
 * B端商品分类管理业务接口：定义分类树查询、新增、更新、删除能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface CategoryService {

    List<Category> tree();

    void create(CategoryDTO dto);

    void update(CategoryDTO dto);

    void delete(Long id);
}
