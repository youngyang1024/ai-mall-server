package com.aimall.toc.service;

import com.aimall.common.entity.Spu;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.vo.ProductDetailVO;

import java.math.BigDecimal;
import java.util.List;

/**
 * C端商品服务接口：商品分页列表/关键词搜索/商品详情/热销及个性化推荐
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface ProductService {

    PageResult<Spu> list(Long categoryId, String sortBy, BigDecimal minPrice, BigDecimal maxPrice, int pageNum, int pageSize);

    PageResult<Spu> search(String keyword, String sortBy, BigDecimal minPrice, BigDecimal maxPrice, int pageNum, int pageSize);

    ProductDetailVO detail(Long spuId);

    List<Spu> recommendHot(int limit);

    List<Spu> recommendForYou(Long spuId, int limit);

    List<Spu> recommendViewedAlso(String keyword, int limit);

    List<Spu> recommendBoughtAlso(Long categoryId, int limit);
}
