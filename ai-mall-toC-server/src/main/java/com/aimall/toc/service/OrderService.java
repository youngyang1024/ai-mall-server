package com.aimall.toc.service;

import com.aimall.common.vo.PageResult;
import com.aimall.toc.dto.OrderCreateDTO;
import com.aimall.toc.vo.OrderCreateResultVO;
import com.aimall.toc.vo.OrderVO;

public interface OrderService {

    OrderCreateResultVO create(Long userId, OrderCreateDTO dto);

    void pay(Long userId, String orderNo);

    void cancel(Long userId, String orderNo);

    void confirm(Long userId, String orderNo);

    void cancelExpiredOrder(String orderNo);

    PageResult<OrderVO> list(Long userId, Integer status, int pageNum, int pageSize);

    OrderVO detail(Long userId, String orderNo);
}
