package com.aimall.toc.service;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.entity.FaqCategory;

import java.util.List;

/**
 * C端帮助中心 FAQ 服务接口：FAQ 分类列表/文章列表（支持分类与关键词筛选）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface FaqService {
    List<FaqCategory> getCategoryList();
    List<FaqArticle> getArticleList(Long categoryId, String keyword);
}
