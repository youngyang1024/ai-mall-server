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
 * 超时未支付订单定时兜底扫描任务（cron 由 order.timeout-scan-cron 配置，默认每 5 分钟）
 *
 * <p>1. 按 OrderProperties 配置的支付超时时长（默认 30 分钟）计算截止时间，扫描创建时间早于截止时间且仍为待支付的订单
 * <p>2. 逐单调用 OrderService.cancelExpiredOrder 幂等取消（回滚库存）
 * <p>3. 与 OrderTimeoutListener 构成双保险：Redis 过期事件监听为主机制（实时），本任务作为兜底，防止过期事件丢失（如服务重启期间）导致订单长期滞留待支付状态
 *
 * @author
 * Created by Yang on 2026/07/16
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
