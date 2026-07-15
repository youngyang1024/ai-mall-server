package com.aimall.tob.service.impl;

import com.aimall.common.constant.OrderStatus;
import com.aimall.common.entity.Order;
import com.aimall.common.entity.OrderItem;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.ShipOrderDTO;
import com.aimall.tob.mapper.OrderItemMapper;
import com.aimall.tob.mapper.OrderMapper;
import com.aimall.tob.service.OrderService;
import com.aimall.tob.vo.OrderDetailVO;
import com.aimall.tob.vo.OrderItemVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;

    public OrderServiceImpl(OrderMapper orderMapper, OrderItemMapper orderItemMapper) {
        this.orderMapper = orderMapper;
        this.orderItemMapper = orderItemMapper;
    }

    @Override
    public PageResult<OrderDetailVO> list(String orderNo, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orders = orderMapper.selectList(orderNo, status);
        PageInfo<Order> pageInfo = new PageInfo<>(orders);
        List<OrderDetailVO> list = orders.stream().map(this::toSummaryVO).collect(Collectors.toList());
        return PageResult.of(list, pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public OrderDetailVO detail(String orderNo) {
        Order order = requireOrder(orderNo);
        OrderDetailVO vo = toDetailVO(order);
        List<OrderItem> items = orderItemMapper.selectByOrderId(order.getId());
        vo.setItems(items.stream().map(this::toItemVO).collect(Collectors.toList()));
        return vo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void ship(String orderNo, ShipOrderDTO dto) {
        Order order = requireOrder(orderNo);
        if (order.getStatus() != OrderStatus.PAID.getCode()) {
            throw new BusinessException("仅待发货订单可发货");
        }
        int affected = orderMapper.updateShip(order.getId(), dto.getLogisticsNo(), LocalDateTime.now());
        if (affected == 0) {
            throw new BusinessException("发货失败，请重试");
        }
    }

    private Order requireOrder(String orderNo) {
        Order order = orderMapper.selectByOrderNo(orderNo);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        return order;
    }

    private OrderDetailVO toSummaryVO(Order order) {
        OrderDetailVO vo = new OrderDetailVO();
        BeanUtils.copyProperties(order, vo);
        vo.setStatusDesc(OrderStatus.of(order.getStatus()).getDesc());
        return vo;
    }

    private OrderDetailVO toDetailVO(Order order) {
        return toSummaryVO(order);
    }

    private OrderItemVO toItemVO(OrderItem item) {
        OrderItemVO vo = new OrderItemVO();
        BeanUtils.copyProperties(item, vo);
        return vo;
    }
}
