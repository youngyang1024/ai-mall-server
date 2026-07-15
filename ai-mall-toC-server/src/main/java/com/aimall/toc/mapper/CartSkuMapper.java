package com.aimall.toc.mapper;

import com.aimall.common.entity.Sku;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CartSkuMapper {

    Sku selectById(@Param("id") Long id);

    Integer selectSpuStatusBySkuId(@Param("skuId") Long skuId);
}
