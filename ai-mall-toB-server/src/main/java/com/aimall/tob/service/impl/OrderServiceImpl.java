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

/**
 * B端订单管理服务实现
 * <p>1. 列表/详情：基于 PageHelper 按订单号/状态/用户/下单时间区间分页查询，详情按订单聚合 OrderItem 商品明细
 * <p>2. 发货：先校验订单存在且当前为已支付（待发货）状态，事务内以条件更新（WHERE status = 待发货）写入物流单号与发货时间并将状态流转为已发货
 * <p>3. 条件更新影响行数为 0 即视为状态已变更或并发冲突，抛出 BusinessException 回滚
 * <p>4. 依赖 OrderMapper、OrderItemMapper
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class OrderServiceImpl implements OrderService {

    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;

    public OrderServiceImpl(OrderMapper orderMapper, OrderItemMapper orderItemMapper) {
        this.orderMapper = orderMapper;
        this.orderItemMapper = orderItemMapper;
    }

    @Override
    public PageResult<OrderDetailVO> list(String orderNo, Integer status, Long userId,
                                          String startTime, String endTime, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orders = orderMapper.selectList(orderNo, status, userId, startTime, endTime);
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
