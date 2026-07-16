package com.aimall.tob.mapper;

import com.aimall.common.entity.FaqArticle;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * t_faq_article 表数据访问，提供 FAQ 文章新增、更新、删除、按分类/标题条件列表查询等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface FaqArticleMapper {
    int insert(FaqArticle faqArticle);
    int update(FaqArticle faqArticle);
    int deleteById(Long id);
    FaqArticle selectById(Long id);
    List<FaqArticle> selectList(@Param("categoryId") Long categoryId, @Param("title") String title);
}
