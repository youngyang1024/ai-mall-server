package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.ShipOrderDTO;
import com.aimall.tob.vo.OrderDetailVO;

/**
 * B端订单管理业务接口：定义订单分页查询（支持按订单号、状态、用户、时间范围筛选）、详情查询、发货能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface OrderService {

    PageResult<OrderDetailVO> list(String orderNo, Integer status, Long userId,
                                   String startTime, String endTime, int pageNum, int pageSize);

    OrderDetailVO detail(String orderNo);

    void ship(String orderNo, ShipOrderDTO dto);
}
