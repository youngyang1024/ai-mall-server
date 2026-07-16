package com.aimall.toc.service;

import com.aimall.toc.dto.CartAddDTO;
import com.aimall.toc.dto.CartUpdateDTO;
import com.aimall.toc.vo.CartItemVO;

import java.util.List;

/**
 * C端购物车服务接口：购物车列表/加购/更新/全选勾选/删除/清空
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface CartService {

    List<CartItemVO> list(Long userId);

    void add(Long userId, CartAddDTO dto);

    void update(Long userId, CartUpdateDTO dto);

    void checkAll(Long userId, Integer checked);

    void delete(Long userId, Long cartId);

    void clear(Long userId);
}
