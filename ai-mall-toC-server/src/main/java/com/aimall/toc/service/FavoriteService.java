package com.aimall.toc.service;

import com.aimall.common.vo.PageResult;
import com.aimall.toc.vo.FavoriteItemVO;

/**
 * C端商品收藏（心愿单）服务接口：收藏/取消收藏/分页列表/收藏状态查询/收藏数统计
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface FavoriteService {

    void add(Long userId, Long spuId);

    void remove(Long userId, Long spuId);

    PageResult<FavoriteItemVO> list(Long userId, int pageNum, int pageSize);

    boolean check(Long userId, Long spuId);

    long count(Long userId);
}
