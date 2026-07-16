package com.aimall.toc.mapper;

import com.aimall.common.entity.Favorite;
import com.aimall.toc.vo.FavoriteItemVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 收藏（心愿单）表 Mapper：收藏的新增、取消、去重查询及用户收藏列表与计数
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface FavoriteMapper {

    int insert(Favorite favorite);

    int deleteByUserIdAndSpuId(@Param("userId") Long userId, @Param("spuId") Long spuId);

    Favorite selectByUserIdAndSpuId(@Param("userId") Long userId, @Param("spuId") Long spuId);

    List<FavoriteItemVO> selectByUserId(@Param("userId") Long userId);

    long countByUserId(@Param("userId") Long userId);
}
