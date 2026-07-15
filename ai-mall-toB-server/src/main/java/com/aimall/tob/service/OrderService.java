package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.ShipOrderDTO;
import com.aimall.tob.vo.OrderDetailVO;

public interface OrderService {

    PageResult<OrderDetailVO> list(String orderNo, Integer status, int pageNum, int pageSize);

    OrderDetailVO detail(String orderNo);

    void ship(String orderNo, ShipOrderDTO dto);
}
