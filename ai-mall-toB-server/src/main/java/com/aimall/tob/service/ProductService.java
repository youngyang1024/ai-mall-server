package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.common.entity.Spu;
import com.aimall.tob.dto.ProductSaveDTO;
import com.aimall.tob.vo.ProductDetailVO;

/**
 * B端商品管理业务接口：定义商品Spu分页查询、详情查询、新增、更新、上下架状态变更、Sku库存调整能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface ProductService {

    PageResult<Spu> list(Long id, String name, Long categoryId, Integer status, int pageNum, int pageSize);

    ProductDetailVO detail(Long spuId);

    Long create(ProductSaveDTO dto);

    void update(Long spuId, ProductSaveDTO dto);

    void updateStatus(Long spuId, Integer status);

    void updateSkuStock(Long skuId, Integer stock);
}
