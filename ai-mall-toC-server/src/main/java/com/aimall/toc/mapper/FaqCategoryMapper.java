package com.aimall.toc.mapper;

import com.aimall.common.entity.FaqCategory;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface FaqCategoryMapper {
    List<FaqCategory> selectEnabledList();
}
