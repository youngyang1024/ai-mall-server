package com.aimall.tob.service;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.vo.PageResult;

public interface FaqArticleService {
    PageResult<FaqArticle> getPageList(Integer pageNum, Integer pageSize, Long categoryId, String title);
    void save(FaqArticle article);
    void update(FaqArticle article);
    void delete(Long id);
}
