package com.aimall.tob.service;

import com.aimall.common.entity.Category;
import com.aimall.tob.dto.CategoryDTO;

import java.util.List;

public interface CategoryService {

    List<Category> tree();

    void create(CategoryDTO dto);

    void update(CategoryDTO dto);

    void delete(Long id);
}
