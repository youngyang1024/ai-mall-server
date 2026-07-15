package com.aimall.toc.mapper;

import com.aimall.common.entity.Sku;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SkuMapper {

    List<Sku> selectBySpuId(@Param("spuId") Long spuId);

    Sku selectById(@Param("id") Long id);

    int deductStock(@Param("id") Long id, @Param("quantity") Integer quantity);

    int restoreStock(@Param("id") Long id, @Param("quantity") Integer quantity);
}
