package com.aimall.toc.task;

import com.aimall.common.entity.Order;
import com.aimall.toc.config.OrderProperties;
import com.aimall.toc.mapper.OrderMapper;
import com.aimall.toc.service.OrderService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 订单超时兜底扫描（每 5 分钟），防止 Redis 过期事件丢失
 */
@Component
public class OrderTimeoutScheduleTask {

    private final OrderMapper orderMapper;
    private final OrderService orderService;
    private final OrderProperties orderProperties;

    public OrderTimeoutScheduleTask(OrderMapper orderMapper, OrderService orderService,
                                    OrderProperties orderProperties) {
        this.orderMapper = orderMapper;
        this.orderService = orderService;
        this.orderProperties = orderProperties;
    }

    @Scheduled(cron = "${order.timeout-scan-cron}")
    public void scanExpiredOrders() {
        LocalDateTime beforeTime = LocalDateTime.now()
                .minusMinutes(orderProperties.getPayTimeoutMinutes());
        List<Order> expiredOrders = orderMapper.selectExpiredUnpaid(beforeTime);
        for (Order order : expiredOrders) {
            orderService.cancelExpiredOrder(order.getOrderNo());
        }
    }
}
