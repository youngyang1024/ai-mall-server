package com.aimall.toc.service;

import com.aimall.common.vo.PageResult;
import com.aimall.toc.dto.OrderCreateDTO;
import com.aimall.toc.vo.OrderCreateResultVO;
import com.aimall.toc.vo.OrderVO;

/**
 * C端订单服务接口：下单/支付/取消/确认收货/超时订单取消/订单列表/订单详情
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface OrderService {

    OrderCreateResultVO create(Long userId, OrderCreateDTO dto);

    void pay(Long userId, String orderNo);

    void cancel(Long userId, String orderNo);

    void confirm(Long userId, String orderNo);

    void cancelExpiredOrder(String orderNo);

    PageResult<OrderVO> list(Long userId, Integer status, int pageNum, int pageSize);

    OrderVO detail(Long userId, String orderNo);
}
