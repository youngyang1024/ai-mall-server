package com.aimall.tob.mapper;

import com.aimall.common.entity.FaqCategory;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface FaqCategoryMapper {
    int insert(FaqCategory faqCategory);
    int update(FaqCategory faqCategory);
    int deleteById(Long id);
    FaqCategory selectById(Long id);
    List<FaqCategory> selectList();
}
