package com.aimall.tob.mapper;

import com.aimall.common.entity.Sku;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_sku 表数据访问，提供按 SPU ID 查询 SKU 列表、新增、删除及库存更新、库存回补等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface SkuMapper {

    List<Sku> selectBySpuId(@Param("spuId") Long spuId);

    Sku selectById(@Param("id") Long id);

    int insert(Sku sku);

    int deleteBySpuId(@Param("spuId") Long spuId);

    int restoreStock(@Param("id") Long id, @Param("quantity") Integer quantity);

    int updateStock(@Param("id") Long id, @Param("stock") Integer stock);
}
