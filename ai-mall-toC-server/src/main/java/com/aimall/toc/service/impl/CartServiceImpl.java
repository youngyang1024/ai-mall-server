package com.aimall.toc.service.impl;

import com.aimall.common.entity.Cart;
import com.aimall.common.entity.Sku;
import com.aimall.common.entity.Spu;
import com.aimall.common.exception.BusinessException;
import com.aimall.toc.dto.CartAddDTO;
import com.aimall.toc.dto.CartUpdateDTO;
import com.aimall.toc.mapper.CartMapper;
import com.aimall.toc.mapper.SkuMapper;
import com.aimall.toc.mapper.SpuMapper;
import com.aimall.toc.service.CartService;
import com.aimall.toc.vo.CartItemVO;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CartServiceImpl implements CartService {

    private final CartMapper cartMapper;
    private final SkuMapper skuMapper;
    private final SpuMapper spuMapper;

    public CartServiceImpl(CartMapper cartMapper, SkuMapper skuMapper, SpuMapper spuMapper) {
        this.cartMapper = cartMapper;
        this.skuMapper = skuMapper;
        this.spuMapper = spuMapper;
    }

    @Override
    public List<CartItemVO> list(Long userId) {
        return cartMapper.selectByUserId(userId);
    }

    /**
     * 加入购物车
     *
     * 流程说明：
     * 1. 校验 SKU 存在且所属商品已上架
     * 2. 校验库存是否充足
     * 3. 若购物车已有该 SKU，则累加数量；否则新增记录
     */
    @Override
    public void add(Long userId, CartAddDTO dto) {
        Sku sku = validateSkuForCart(dto.getSkuId(), dto.getQuantity());
        Cart exist = cartMapper.selectByUserIdAndSkuId(userId, dto.getSkuId());
        if (exist != null) {
            int newQty = exist.getQuantity() + dto.getQuantity();
            if (newQty > sku.getStock()) {
                throw new BusinessException("库存不足");
            }
            exist.setQuantity(newQty);
            exist.setChecked(1);
            cartMapper.update(exist);
        } else {
            Cart cart = new Cart();
            cart.setUserId(userId);
            cart.setSkuId(dto.getSkuId());
            cart.setQuantity(dto.getQuantity());
            cart.setChecked(1);
            cartMapper.insert(cart);
        }
    }

    @Override
    public void update(Long userId, CartUpdateDTO dto) {
        Cart cart = cartMapper.selectById(dto.getId());
        if (cart == null || !cart.getUserId().equals(userId)) {
            throw new BusinessException("购物车项不存在");
        }
        
        Long targetSkuId = dto.getSkuId() != null ? dto.getSkuId() : cart.getSkuId();
        Sku sku = validateSkuForCart(targetSkuId, dto.getQuantity());
        if (dto.getQuantity() > sku.getStock()) {
            throw new BusinessException("库存不足");
        }
        
        if (dto.getSkuId() != null && !dto.getSkuId().equals(cart.getSkuId())) {
            // Check if target skuId already exists in cart for this user
            Cart exist = cartMapper.selectByUserIdAndSkuId(userId, dto.getSkuId());
            if (exist != null && !exist.getId().equals(cart.getId())) {
                // Merge quantities and delete old cart item
                int newQty = exist.getQuantity() + dto.getQuantity();
                if (newQty > sku.getStock()) {
                    throw new BusinessException("目标规格库存不足");
                }
                exist.setQuantity(newQty);
                if (dto.getChecked() != null) {
                    exist.setChecked(dto.getChecked());
                }
                cartMapper.update(exist);
                cartMapper.deleteById(cart.getId());
                return;
            }
            cart.setSkuId(dto.getSkuId());
        }
        
        cart.setQuantity(dto.getQuantity());
        if (dto.getChecked() != null) {
            cart.setChecked(dto.getChecked());
        }
        cartMapper.update(cart);
    }

    @Override
    public void delete(Long userId, Long cartId) {
        Cart cart = cartMapper.selectById(cartId);
        if (cart == null || !cart.getUserId().equals(userId)) {
            throw new BusinessException("购物车项不存在");
        }
        cartMapper.deleteById(cartId);
    }

    @Override
    public void clear(Long userId) {
        cartMapper.deleteByUserId(userId);
    }

    private Sku validateSkuForCart(Long skuId, int quantity) {
        Sku sku = skuMapper.selectById(skuId);
        if (sku == null) {
            throw new BusinessException("商品规格不存在");
        }
        Spu spu = spuMapper.selectOnShelfById(sku.getSpuId());
        if (spu == null) {
            throw new BusinessException("商品已下架");
        }
        if (quantity > sku.getStock()) {
            throw new BusinessException("库存不足");
        }
        return sku;
    }
}
