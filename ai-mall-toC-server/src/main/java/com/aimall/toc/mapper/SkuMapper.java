package com.aimall.toc.mapper;

import com.aimall.common.entity.Sku;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * SKU 表 Mapper：SKU 查询，及库存的原子扣减（防超卖）与回补
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface SkuMapper {

    List<Sku> selectBySpuId(@Param("spuId") Long spuId);

    Sku selectById(@Param("id") Long id);

    int deductStock(@Param("id") Long id, @Param("quantity") Integer quantity);

    int restoreStock(@Param("id") Long id, @Param("quantity") Integer quantity);
}
