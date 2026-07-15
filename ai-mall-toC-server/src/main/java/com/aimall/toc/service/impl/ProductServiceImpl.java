package com.aimall.toc.service.impl;

import com.aimall.common.entity.Spu;
import com.aimall.common.entity.SpuSpec;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.mapper.OrderItemMapper;
import com.aimall.toc.mapper.SkuMapper;
import com.aimall.toc.mapper.SpuImageMapper;
import com.aimall.toc.mapper.SpuMapper;
import com.aimall.toc.mapper.SpuSpecMapper;
import com.aimall.toc.service.ProductService;
import com.aimall.toc.vo.ProductDetailVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService {

    private final SpuMapper spuMapper;
    private final SkuMapper skuMapper;
    private final SpuSpecMapper spuSpecMapper;
    private final SpuImageMapper spuImageMapper;
    private final OrderItemMapper orderItemMapper;

    public ProductServiceImpl(SpuMapper spuMapper, SkuMapper skuMapper,
                              SpuSpecMapper spuSpecMapper, SpuImageMapper spuImageMapper,
                              OrderItemMapper orderItemMapper) {
        this.spuMapper = spuMapper;
        this.skuMapper = skuMapper;
        this.spuSpecMapper = spuSpecMapper;
        this.spuImageMapper = spuImageMapper;
        this.orderItemMapper = orderItemMapper;
    }

    @Override
    public PageResult<Spu> list(Long categoryId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Spu> list = spuMapper.selectOnShelfList(null, categoryId);
        PageInfo<Spu> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public PageResult<Spu> search(String keyword, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Spu> list = spuMapper.selectOnShelfList(keyword, null);
        PageInfo<Spu> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public ProductDetailVO detail(Long spuId) {
        Spu spu = spuMapper.selectOnShelfById(spuId);
        if (spu == null) {
            throw new BusinessException("商品不存在或已下架");
        }
        ProductDetailVO vo = new ProductDetailVO();
        vo.setSpu(spu);
        vo.setSkus(skuMapper.selectBySpuId(spuId));
        vo.setImages(spuImageMapper.selectBySpuId(spuId));
        List<SpuSpec> specs = spuSpecMapper.selectBySpuId(spuId);
        vo.setSpecs(specs.stream().map(spec -> {
            ProductDetailVO.SpecItemVO item = new ProductDetailVO.SpecItemVO();
            item.setSpecName(spec.getSpecName());
            item.setSpecValues(Arrays.stream(spec.getSpecValues().split(","))
                    .map(String::trim)
                    .filter(StringUtils::hasText)
                    .collect(Collectors.toList()));
            return item;
        }).collect(Collectors.toList()));
        return vo;
    }

    @Override
    public List<Spu> recommendHot(int limit) {
        return spuMapper.selectHotSales(normalizeLimit(limit));
    }

    @Override
    public List<Spu> recommendForYou(Long spuId, int limit) {
        if (spuId == null) {
            return recommendHot(normalizeLimit(limit));
        }
        List<Spu> list = spuMapper.selectForYou(spuId, normalizeLimit(limit));
        if (list.isEmpty()) {
            return recommendHot(normalizeLimit(limit));
        }
        return list;
    }

    @Override
    public List<Spu> recommendViewedAlso(String keyword, int limit) {
        int size = normalizeLimit(limit);
        if (!StringUtils.hasText(keyword)) {
            return recommendHot(size);
        }
        List<Spu> list = spuMapper.selectViewedAlso(keyword.trim(), size);
        if (list.isEmpty()) {
            return recommendHot(size);
        }
        return list;
    }

    @Override
    public List<Spu> recommendBoughtAlso(Long categoryId, int limit) {
        int size = normalizeLimit(limit);
        if (categoryId == null) {
            return recommendHot(size);
        }
        List<Long> coPurchasedIds = orderItemMapper.selectCoPurchasedSpuIds(categoryId, size);
        if (!coPurchasedIds.isEmpty()) {
            return spuMapper.selectByIds(coPurchasedIds);
        }
        return spuMapper.selectBoughtAlsoFallback(categoryId, size);
    }

    private int normalizeLimit(int limit) {
        if (limit <= 0) {
            return 8;
        }
        return Math.min(limit, 20);
    }
}
