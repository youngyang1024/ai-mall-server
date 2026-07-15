package com.aimall.toc.service.impl;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.entity.FaqCategory;
import com.aimall.toc.mapper.FaqArticleMapper;
import com.aimall.toc.mapper.FaqCategoryMapper;
import com.aimall.toc.service.FaqService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FaqServiceImpl implements FaqService {

    @Autowired
    private FaqCategoryMapper categoryMapper;

    @Autowired
    private FaqArticleMapper articleMapper;

    @Override
    public List<FaqCategory> getCategoryList() {
        return categoryMapper.selectEnabledList();
    }

    @Override
    public List<FaqArticle> getArticleList(Long categoryId, String keyword) {
        return articleMapper.selectEnabledList(categoryId, keyword);
    }
}
