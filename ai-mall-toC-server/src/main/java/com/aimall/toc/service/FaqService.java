package com.aimall.toc.service;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.entity.FaqCategory;

import java.util.List;

public interface FaqService {
    List<FaqCategory> getCategoryList();
    List<FaqArticle> getArticleList(Long categoryId, String keyword);
}
