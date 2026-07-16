package com.aimall.toc.mapper;

import com.aimall.common.entity.Spu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

/**
 * SPU 表 Mapper：在架商品的条件检索与详情查询、热销/推荐类查询及销量累加
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface SpuMapper {

    List<Spu> selectOnShelfList(@Param("name") String name, @Param("categoryId") Long categoryId,
                                @Param("orderBy") String orderBy,
                                @Param("minPrice") BigDecimal minPrice, @Param("maxPrice") BigDecimal maxPrice);

    Spu selectOnShelfById(@Param("id") Long id);

    List<Spu> selectHotSales(@Param("limit") int limit);

    List<Spu> selectForYou(@Param("spuId") Long spuId, @Param("limit") int limit);

    List<Spu> selectViewedAlso(@Param("keyword") String keyword, @Param("limit") int limit);

    List<Spu> selectByIds(@Param("ids") List<Long> ids);

    List<Spu> selectBoughtAlsoFallback(@Param("categoryId") Long categoryId, @Param("limit") int limit);

    int incrementSalesCount(@Param("spuId") Long spuId, @Param("quantity") int quantity);
}
