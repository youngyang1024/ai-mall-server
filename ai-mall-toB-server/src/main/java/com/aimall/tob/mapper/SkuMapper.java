package com.aimall.tob.mapper;

import com.aimall.common.entity.Sku;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SkuMapper {

    List<Sku> selectBySpuId(@Param("spuId") Long spuId);

    int insert(Sku sku);

    int deleteBySpuId(@Param("spuId") Long spuId);

    int restoreStock(@Param("id") Long id, @Param("quantity") Integer quantity);
}
