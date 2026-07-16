package com.aimall.toc.service.impl;

import com.aimall.common.entity.Favorite;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.mapper.FavoriteMapper;
import com.aimall.toc.mapper.SpuMapper;
import com.aimall.toc.service.FavoriteService;
import com.aimall.toc.vo.FavoriteItemVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * C端商品收藏（心愿单）服务实现：收藏/取消收藏、收藏分页列表、收藏状态查询与计数；收藏前校验商品在架，重复收藏（含并发 DuplicateKey）幂等成功
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class FavoriteServiceImpl implements FavoriteService {

    private final FavoriteMapper favoriteMapper;
    private final SpuMapper spuMapper;

    public FavoriteServiceImpl(FavoriteMapper favoriteMapper, SpuMapper spuMapper) {
        this.favoriteMapper = favoriteMapper;
        this.spuMapper = spuMapper;
    }

    /**
     * 收藏商品（重复收藏幂等成功）
     */
    @Override
    public void add(Long userId, Long spuId) {
        if (spuMapper.selectOnShelfById(spuId) == null) {
            throw new BusinessException("商品不存在或已下架");
        }
        if (favoriteMapper.selectByUserIdAndSpuId(userId, spuId) != null) {
            return;
        }
        Favorite favorite = new Favorite();
        favorite.setUserId(userId);
        favorite.setSpuId(spuId);
        try {
            favoriteMapper.insert(favorite);
        } catch (DuplicateKeyException e) {
            // 并发重复收藏，幂等成功
        }
    }

    @Override
    public void remove(Long userId, Long spuId) {
        favoriteMapper.deleteByUserIdAndSpuId(userId, spuId);
    }

    @Override
    public PageResult<FavoriteItemVO> list(Long userId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<FavoriteItemVO> list = favoriteMapper.selectByUserId(userId);
        PageInfo<FavoriteItemVO> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public boolean check(Long userId, Long spuId) {
        return favoriteMapper.selectByUserIdAndSpuId(userId, spuId) != null;
    }

    @Override
    public long count(Long userId) {
        return favoriteMapper.countByUserId(userId);
    }
}
