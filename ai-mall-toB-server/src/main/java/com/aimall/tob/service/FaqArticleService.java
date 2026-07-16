package com.aimall.tob.service;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.vo.PageResult;

/**
 * B端FAQ文章管理业务接口：定义文章分页查询（支持按分类、标题筛选）、保存、更新、删除能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface FaqArticleService {
    PageResult<FaqArticle> getPageList(Integer pageNum, Integer pageSize, Long categoryId, String title);
    void save(FaqArticle article);
    void update(FaqArticle article);
    void delete(Long id);
}
