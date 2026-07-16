package com.aimall.toc.mapper;

import com.aimall.common.entity.FaqCategory;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

/**
 * FAQ 分类表 Mapper：查询已启用的帮助中心分类列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface FaqCategoryMapper {
    List<FaqCategory> selectEnabledList();
}
