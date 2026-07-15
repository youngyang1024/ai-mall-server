package com.aimall.tob.service.impl;

import com.aimall.common.entity.Sku;
import com.aimall.common.entity.Spu;
import com.aimall.common.entity.SpuImage;
import com.aimall.common.entity.SpuSpec;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.ProductSaveDTO;
import com.aimall.tob.mapper.SkuMapper;
import com.aimall.tob.mapper.SpuImageMapper;
import com.aimall.tob.mapper.SpuMapper;
import com.aimall.tob.mapper.SpuSpecMapper;
import com.aimall.tob.service.ProductService;
import com.aimall.tob.vo.ProductDetailVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    private final SpuMapper spuMapper;
    private final SkuMapper skuMapper;
    private final SpuSpecMapper spuSpecMapper;
    private final SpuImageMapper spuImageMapper;

    public ProductServiceImpl(SpuMapper spuMapper, SkuMapper skuMapper,
                              SpuSpecMapper spuSpecMapper, SpuImageMapper spuImageMapper) {
        this.spuMapper = spuMapper;
        this.skuMapper = skuMapper;
        this.spuSpecMapper = spuSpecMapper;
        this.spuImageMapper = spuImageMapper;
    }

    @Override
    public PageResult<Spu> list(String name, Long categoryId, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Spu> list = spuMapper.selectList(name, categoryId, status);
        PageInfo<Spu> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public ProductDetailVO detail(Long spuId) {
        Spu spu = spuMapper.selectById(spuId);
        if (spu == null) {
            throw new BusinessException("商品不存在");
        }
        ProductDetailVO vo = new ProductDetailVO();
        vo.setSpu(spu);
        vo.setSpecs(spuSpecMapper.selectBySpuId(spuId));
        vo.setSkus(skuMapper.selectBySpuId(spuId));
        vo.setImages(spuImageMapper.selectBySpuId(spuId));
        return vo;
    }

    /**
     * 创建商品
     *
     * 流程说明：
     * 1. 保存 SPU 主信息
     * 2. 保存规格维度（颜色/尺码等）
     * 3. 保存 SKU 列表（各规格组合的价格与库存）
     * 4. 保存商品图册
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long create(ProductSaveDTO dto) {
        Spu spu = buildSpu(dto);
        spuMapper.insert(spu);
        saveSpecsAndSkus(spu.getId(), dto);
        saveImages(spu.getId(), dto.getImages());
        return spu.getId();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void update(Long spuId, ProductSaveDTO dto) {
        Spu exist = spuMapper.selectById(spuId);
        if (exist == null) {
            throw new BusinessException("商品不存在");
        }
        Spu spu = buildSpu(dto);
        spu.setId(spuId);
        spuMapper.update(spu);
        spuSpecMapper.deleteBySpuId(spuId);
        skuMapper.deleteBySpuId(spuId);
        spuImageMapper.deleteBySpuId(spuId);
        saveSpecsAndSkus(spuId, dto);
        saveImages(spuId, dto.getImages());
    }

    @Override
    public void updateStatus(Long spuId, Integer status) {
        Spu exist = spuMapper.selectById(spuId);
        if (exist == null) {
            throw new BusinessException("商品不存在");
        }
        spuMapper.updateStatus(spuId, status);
    }

    private Spu buildSpu(ProductSaveDTO dto) {
        Spu spu = new Spu();
        spu.setName(dto.getName());
        spu.setCategoryId(dto.getCategoryId());
        spu.setDescription(dto.getDescription());
        spu.setMainImage(dto.getMainImage());
        spu.setStatus(dto.getStatus());
        return spu;
    }

    private void saveSpecsAndSkus(Long spuId, ProductSaveDTO dto) {
        for (ProductSaveDTO.SpecDTO specDTO : dto.getSpecs()) {
            SpuSpec spec = new SpuSpec();
            spec.setSpuId(spuId);
            spec.setSpecName(specDTO.getSpecName());
            spec.setSpecValues(specDTO.getSpecValues());
            spuSpecMapper.insert(spec);
        }
        for (ProductSaveDTO.SkuDTO skuDTO : dto.getSkus()) {
            Sku sku = new Sku();
            sku.setSpuId(spuId);
            sku.setSpecJson(skuDTO.getSpecJson());
            sku.setPrice(skuDTO.getPrice());
            sku.setStock(skuDTO.getStock());
            sku.setImage(skuDTO.getImage());
            sku.setSkuCode(skuDTO.getSkuCode());
            skuMapper.insert(sku);
        }
    }

    private void saveImages(Long spuId, List<String> images) {
        if (CollectionUtils.isEmpty(images)) {
            return;
        }
        int sort = 0;
        for (String imageUrl : images) {
            SpuImage image = new SpuImage();
            image.setSpuId(spuId);
            image.setImageUrl(imageUrl);
            image.setSort(sort++);
            spuImageMapper.insert(image);
        }
    }
}
