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

/**
 * B端FAQ分类管理服务实现，基于 FaqCategoryMapper 提供 PageHelper 分页查询与增删改
 *
 * @author
 * Created by Yang on 2026/07/16
 */
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
