package com.aimall.toc.mapper;

import com.aimall.common.entity.FaqArticle;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface FaqArticleMapper {
    List<FaqArticle> selectEnabledList(@Param("categoryId") Long categoryId, @Param("keyword") String keyword);
}
