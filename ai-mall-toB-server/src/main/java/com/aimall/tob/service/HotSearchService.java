package com.aimall.tob.service;

import com.aimall.common.entity.HotSearch;
import com.aimall.tob.dto.HotSearchDTO;

import java.util.List;

public interface HotSearchService {
    List<HotSearch> getList();
    HotSearch getById(Long id);
    void create(HotSearchDTO dto);
    void update(HotSearchDTO dto);
    void delete(Long id);
}