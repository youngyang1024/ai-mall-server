package com.aimall.tob.service;

import com.aimall.common.entity.FaqCategory;
import com.aimall.common.vo.PageResult;

public interface FaqCategoryService {
    PageResult<FaqCategory> getPageList(Integer pageNum, Integer pageSize);
    void save(FaqCategory category);
    void update(FaqCategory category);
    void delete(Long id);
}
