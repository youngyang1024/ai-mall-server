package com.aimall.toc.mapper;

import com.aimall.common.entity.Cart;
import com.aimall.toc.vo.CartItemVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CartMapper {

    List<CartItemVO> selectByUserId(@Param("userId") Long userId);

    Cart selectByUserIdAndSkuId(@Param("userId") Long userId, @Param("skuId") Long skuId);

    Cart selectById(@Param("id") Long id);

    int insert(Cart cart);

    int update(Cart cart);

    int deleteById(@Param("id") Long id);

    int deleteByUserId(@Param("userId") Long userId);

    int deleteByUserIdAndSkuIds(@Param("userId") Long userId, @Param("skuIds") List<Long> skuIds);

    int deleteByIds(@Param("userId") Long userId, @Param("ids") List<Long> ids);
}
