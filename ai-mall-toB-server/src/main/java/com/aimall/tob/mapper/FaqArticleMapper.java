package com.aimall.tob.mapper;

import com.aimall.common.entity.FaqArticle;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface FaqArticleMapper {
    int insert(FaqArticle faqArticle);
    int update(FaqArticle faqArticle);
    int deleteById(Long id);
    FaqArticle selectById(Long id);
    List<FaqArticle> selectList(@Param("categoryId") Long categoryId, @Param("title") String title);
}
