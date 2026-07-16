package com.aimall.tob.service;

import com.aimall.common.entity.FaqCategory;
import com.aimall.common.vo.PageResult;

/**
 * B端FAQ分类管理业务接口：定义分类分页查询、保存、更新、删除能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface FaqCategoryService {
    PageResult<FaqCategory> getPageList(Integer pageNum, Integer pageSize);
    void save(FaqCategory category);
    void update(FaqCategory category);
    void delete(Long id);
}
