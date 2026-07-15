package com.aimall.tob.service.impl;

import com.aimall.common.entity.HotSearch;
import com.aimall.tob.dto.HotSearchDTO;
import com.aimall.tob.mapper.HotSearchMapper;
import com.aimall.tob.service.HotSearchService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HotSearchServiceImpl implements HotSearchService {

    @Autowired
    private HotSearchMapper hotSearchMapper;

    @Override
    public List<HotSearch> getList() {
        return hotSearchMapper.selectAll();
    }

    @Override
    public HotSearch getById(Long id) {
        return hotSearchMapper.selectById(id);
    }

    @Override
    public void create(HotSearchDTO dto) {
        HotSearch entity = new HotSearch();
        BeanUtils.copyProperties(dto, entity);
        if (entity.getSort() == null) {
            entity.setSort(0);
        }
        if (entity.getStatus() == null) {
            entity.setStatus(1);
        }
        hotSearchMapper.insert(entity);
    }

    @Override
    public void update(HotSearchDTO dto) {
        HotSearch entity = new HotSearch();
        BeanUtils.copyProperties(dto, entity);
        hotSearchMapper.update(entity);
    }

    @Override
    public void delete(Long id) {
        hotSearchMapper.deleteById(id);
    }
}