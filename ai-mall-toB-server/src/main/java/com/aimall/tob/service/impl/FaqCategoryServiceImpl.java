package com.aimall.tob.service.impl;

import com.aimall.common.entity.FaqCategory;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.mapper.FaqCategoryMapper;
import com.aimall.tob.service.FaqCategoryService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FaqCategoryServiceImpl implements FaqCategoryService {

    @Autowired
    private FaqCategoryMapper categoryMapper;

    @Override
    public PageResult<FaqCategory> getPageList(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<FaqCategory> list = categoryMapper.selectList();
        PageInfo<FaqCategory> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());
    }

    @Override
    public void save(FaqCategory category) {
        categoryMapper.insert(category);
    }

    @Override
    public void update(FaqCategory category) {
        categoryMapper.update(category);
    }

    @Override
    public void delete(Long id) {
        categoryMapper.deleteById(id);
    }
}
