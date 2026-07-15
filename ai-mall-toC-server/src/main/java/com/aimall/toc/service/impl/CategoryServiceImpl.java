package com.aimall.toc.service.impl;

import com.aimall.common.entity.Category;
import com.aimall.common.entity.SpuSpec;
import com.aimall.toc.mapper.CategoryMapper;
import com.aimall.toc.service.CategoryService;
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
        List<Category> all = categoryMapper.selectEnabled();
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
