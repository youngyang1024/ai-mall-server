package com.aimall.tob.mapper;

import com.aimall.common.entity.FaqCategory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

/**
 * t_faq_category 表数据访问，提供 FAQ 分类新增、更新、删除、列表查询等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface FaqCategoryMapper {
    int insert(FaqCategory faqCategory);
    int update(FaqCategory faqCategory);
    int deleteById(Long id);
    FaqCategory selectById(Long id);
    List<FaqCategory> selectList();
}
