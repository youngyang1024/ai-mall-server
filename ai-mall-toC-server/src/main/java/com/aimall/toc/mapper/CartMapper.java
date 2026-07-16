package com.aimall.toc.mapper;

import com.aimall.common.entity.Cart;
import com.aimall.toc.vo.CartItemVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 购物车表 Mapper：购物车条目的增删改查、勾选状态批量更新及按用户/SKU 批量删除
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface CartMapper {

    List<CartItemVO> selectByUserId(@Param("userId") Long userId);

    Cart selectByUserIdAndSkuId(@Param("userId") Long userId, @Param("skuId") Long skuId);

    Cart selectById(@Param("id") Long id);

    int insert(Cart cart);

    int update(Cart cart);

    int updateCheckedByUserId(@Param("userId") Long userId, @Param("checked") Integer checked);

    int deleteById(@Param("id") Long id);

    int deleteByUserId(@Param("userId") Long userId);

    int deleteByUserIdAndSkuIds(@Param("userId") Long userId, @Param("skuIds") List<Long> skuIds);

    int deleteByIds(@Param("userId") Long userId, @Param("ids") List<Long> ids);
}
