package com.aimall.tob.service.impl;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.mapper.FaqArticleMapper;
import com.aimall.tob.service.FaqArticleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FaqArticleServiceImpl implements FaqArticleService {

    @Autowired
    private FaqArticleMapper articleMapper;

    @Override
    public PageResult<FaqArticle> getPageList(Integer pageNum, Integer pageSize, Long categoryId, String title) {
        PageHelper.startPage(pageNum, pageSize);
        List<FaqArticle> list = articleMapper.selectList(categoryId, title);
        PageInfo<FaqArticle> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageInfo.getPageNum(), pageInfo.getPageSize());
    }

    @Override
    public void save(FaqArticle article) {
        articleMapper.insert(article);
    }

    @Override
    public void update(FaqArticle article) {
        articleMapper.update(article);
    }

    @Override
    public void delete(Long id) {
        articleMapper.deleteById(id);
    }
}
