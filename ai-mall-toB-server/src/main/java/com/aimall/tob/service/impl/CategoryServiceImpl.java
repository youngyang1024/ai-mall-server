package com.aimall.tob.service.impl;

import com.aimall.common.entity.Category;
import com.aimall.common.exception.BusinessException;
import com.aimall.tob.dto.CategoryDTO;
import com.aimall.tob.mapper.CategoryMapper;
import com.aimall.tob.service.CategoryService;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class CategoryServiceImpl implements CategoryService {

    private final CategoryMapper categoryMapper;

    public CategoryServiceImpl(CategoryMapper categoryMapper) {
        this.categoryMapper = categoryMapper;
    }

    @Override
    public List<Category> tree() {
        List<Category> all = categoryMapper.selectAll();
        return buildTree(all);
    }

    @Override
    public void create(CategoryDTO dto) {
        Category category = toEntity(dto);
        if (category.getSort() == null) {
            category.setSort(0);
        }
        if (category.getStatus() == null) {
            category.setStatus(1);
        }
        categoryMapper.insert(category);
    }

    @Override
    public void update(CategoryDTO dto) {
        if (dto.getId() == null) {
            throw new BusinessException("分类ID不能为空");
        }
        Category exist = categoryMapper.selectById(dto.getId());
        if (exist == null) {
            throw new BusinessException("分类不存在");
        }
        categoryMapper.update(toEntity(dto));
    }

    @Override
    public void delete(Long id) {
        if (categoryMapper.countByParentId(id) > 0) {
            throw new BusinessException("存在子分类，无法删除");
        }
        if (categoryMapper.countSpuByCategoryId(id) > 0) {
            throw new BusinessException("分类下存在商品，无法删除");
        }
        categoryMapper.deleteById(id);
    }

    private Category toEntity(CategoryDTO dto) {
        Category category = new Category();
        category.setId(dto.getId());
        category.setName(dto.getName());
        category.setParentId(dto.getParentId());
        category.setSort(dto.getSort());
        category.setStatus(dto.getStatus());
        return category;
    }

    private List<Category> buildTree(List<Category> all) {
        Map<Long, List<Category>> childrenMap = all.stream()
                .collect(Collectors.groupingBy(c -> c.getParentId() == null ? 0L : c.getParentId()));
        return buildChildren(childrenMap, 0L);
    }

    private List<Category> buildChildren(Map<Long, List<Category>> childrenMap, Long parentId) {
        List<Category> children = childrenMap.getOrDefault(parentId, new ArrayList<>());
        for (Category child : children) {
            child.setChildren(buildChildren(childrenMap, child.getId()));
        }
        return children;
    }
}
