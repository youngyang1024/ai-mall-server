package com.aimall.toc.mapper;

import com.aimall.common.entity.FaqArticle;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * FAQ 文章表 Mapper：按分类和关键词查询已启用的帮助文章列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface FaqArticleMapper {
    List<FaqArticle> selectEnabledList(@Param("categoryId") Long categoryId, @Param("keyword") String keyword);
}
