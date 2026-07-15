package com.aimall.toc.service;

import com.aimall.common.entity.Spu;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.vo.ProductDetailVO;

import java.util.List;

public interface ProductService {

    PageResult<Spu> list(Long categoryId, int pageNum, int pageSize);

    PageResult<Spu> search(String keyword, int pageNum, int pageSize);

    ProductDetailVO detail(Long spuId);

    List<Spu> recommendHot(int limit);

    List<Spu> recommendForYou(Long spuId, int limit);

    List<Spu> recommendViewedAlso(String keyword, int limit);

    List<Spu> recommendBoughtAlso(Long categoryId, int limit);
}
