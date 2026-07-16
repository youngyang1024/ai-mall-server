package com.aimall.tob.service;

import com.aimall.common.entity.HotSearch;
import com.aimall.tob.dto.HotSearchDTO;

import java.util.List;

/**
 * B端热门搜索词管理业务接口：定义热词列表查询、按id查询、新增、更新、删除能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface HotSearchService {
    List<HotSearch> getList();
    HotSearch getById(Long id);
    void create(HotSearchDTO dto);
    void update(HotSearchDTO dto);
    void delete(Long id);
}