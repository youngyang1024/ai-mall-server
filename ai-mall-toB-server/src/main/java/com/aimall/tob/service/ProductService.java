package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.common.entity.Spu;
import com.aimall.tob.dto.ProductSaveDTO;
import com.aimall.tob.vo.ProductDetailVO;

public interface ProductService {

    PageResult<Spu> list(String name, Long categoryId, Integer status, int pageNum, int pageSize);

    ProductDetailVO detail(Long spuId);

    Long create(ProductSaveDTO dto);

    void update(Long spuId, ProductSaveDTO dto);

    void updateStatus(Long spuId, Integer status);
}
