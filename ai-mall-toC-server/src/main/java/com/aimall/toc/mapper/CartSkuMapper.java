package com.aimall.toc.mapper;

import com.aimall.common.entity.Sku;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * 购物车场景下的 SKU 查询 Mapper：查询 SKU 详情及其所属 SPU 的上架状态
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface CartSkuMapper {

    Sku selectById(@Param("id") Long id);

    Integer selectSpuStatusBySkuId(@Param("skuId") Long skuId);
}
