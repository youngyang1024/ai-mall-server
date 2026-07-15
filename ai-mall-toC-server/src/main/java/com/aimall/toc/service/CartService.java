package com.aimall.toc.service;

import com.aimall.toc.dto.CartAddDTO;
import com.aimall.toc.dto.CartUpdateDTO;
import com.aimall.toc.vo.CartItemVO;

import java.util.List;

public interface CartService {

    List<CartItemVO> list(Long userId);

    void add(Long userId, CartAddDTO dto);

    void update(Long userId, CartUpdateDTO dto);

    void delete(Long userId, Long cartId);

    void clear(Long userId);
}
