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
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * B端商品管理服务实现，负责 SPU/SKU/规格/图册四类数据的组合维护
 * <p>1. 创建：事务内先插入 SPU 主信息，再依次写入规格维度（SpuSpec）、SKU 列表（各规格组合的价格与库存，SKU 图片空串归一化为 NULL 以便查询侧回退 SPU 主图）、商品图册（按传入顺序生成 sort）
 * <p>2. 更新：采用"删除重建"模式，事务内先更新 SPU 主信息，然后删除该 SPU 下全部规格、SKU、图册记录，再按入参重新插入规格/SKU/图册，以整体替换代替逐条差异对比
 * <p>3. 上下架与库存：updateStatus 单独变更 SPU 状态，updateSkuStock 直接覆盖指定 SKU 库存，均先校验记录存在
 * <p>4. 列表基于 PageHelper 分页，详情聚合 SPU、规格、SKU、图册；依赖 SpuMapper、SkuMapper、SpuSpecMapper、SpuImageMapper
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

    public ProductServiceImpl(SpuMapper spuMapper, SkuMapper skuMapper,
                              SpuSpecMapper spuSpecMapper, SpuImageMapper spuImageMapper) {
        this.spuMapper = spuMapper;
        this.skuMapper = skuMapper;
        this.spuSpecMapper = spuSpecMapper;
        this.spuImageMapper = spuImageMapper;
    }

    @Override
    public PageResult<Spu> list(Long id, String name, Long categoryId, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Spu> list = spuMapper.selectList(id, name, categoryId, status);
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

    @Override
    public void updateSkuStock(Long skuId, Integer stock) {
        Sku sku = skuMapper.selectById(skuId);
        if (sku == null) {
            throw new BusinessException("SKU不存在");
        }
        skuMapper.updateStock(skuId, stock);
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
            // 空串归一化为 NULL，SKU 无图时查询侧才能回退 SPU 主图
            sku.setImage(StringUtils.hasText(skuDTO.getImage()) ? skuDTO.getImage() : null);
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
