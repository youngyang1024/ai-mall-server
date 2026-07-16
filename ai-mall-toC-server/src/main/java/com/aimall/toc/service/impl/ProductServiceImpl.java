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

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * C端商品服务实现：在架商品分页列表/关键词搜索（支持价格区间过滤与白名单排序防 SQL 注入）、商品详情聚合（SPU/SKU/图片/规格）、多策略推荐（热销、相似商品、看了又看、买了又买，均以热销兜底）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
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
    public PageResult<Spu> list(Long categoryId, String sortBy, BigDecimal minPrice, BigDecimal maxPrice, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Spu> list = spuMapper.selectOnShelfList(null, categoryId, resolveOrderBy(sortBy), minPrice, maxPrice);
        PageInfo<Spu> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public PageResult<Spu> search(String keyword, String sortBy, BigDecimal minPrice, BigDecimal maxPrice, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Spu> list = spuMapper.selectOnShelfList(keyword, null, resolveOrderBy(sortBy), minPrice, maxPrice);
        PageInfo<Spu> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageNum, pageSize);
    }

    /**
     * 排序白名单：用户输入仅用于 switch 匹配，传给 mapper 的是固定枚举常量，
     * XML 中用 <choose> 按值选择固定 ORDER BY 片段，杜绝 SQL 注入。
     */
    private String resolveOrderBy(String sortBy) {
        if (sortBy == null) {
            return "default";
        }
        switch (sortBy) {
            case "price_asc":
                return "price_asc";
            case "price_desc":
                return "price_desc";
            case "sales":
                return "sales";
            case "newest":
                return "newest";
            default:
                return "default";
        }
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
