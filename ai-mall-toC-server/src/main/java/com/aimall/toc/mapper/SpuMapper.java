package com.aimall.toc.mapper;

import com.aimall.common.entity.Spu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SpuMapper {

    List<Spu> selectOnShelfList(@Param("name") String name, @Param("categoryId") Long categoryId);

    Spu selectOnShelfById(@Param("id") Long id);

    List<Spu> selectHotSales(@Param("limit") int limit);

    List<Spu> selectForYou(@Param("spuId") Long spuId, @Param("limit") int limit);

    List<Spu> selectViewedAlso(@Param("keyword") String keyword, @Param("limit") int limit);

    List<Spu> selectByIds(@Param("ids") List<Long> ids);

    List<Spu> selectBoughtAlsoFallback(@Param("categoryId") Long categoryId, @Param("limit") int limit);

    int incrementSalesCount(@Param("spuId") Long spuId, @Param("quantity") int quantity);
}
