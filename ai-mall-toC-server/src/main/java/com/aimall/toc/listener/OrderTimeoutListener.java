package com.aimall.toc.listener;

import com.aimall.common.constant.RedisKeyConstant;
import com.aimall.toc.service.OrderService;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.stereotype.Component;

/**
 * Redis Key 过期事件监听器，自动取消超时未支付订单的主机制
 *
 * <p>1. 订阅 Redis 过期事件（由 RedisConfig 注册到 __keyevent@0__:expired 主题），仅处理订单超时前缀的 key
 * <p>2. 从过期 key 中解析订单号，调用 OrderService.cancelExpiredOrder 幂等取消（回滚库存）
 * <p>3. 与 OrderTimeoutScheduleTask 定时兜底扫描构成双保险：本监听器实时性高但 Redis 过期事件不保证可靠送达（如服务重启、事件丢失），漏掉的订单由定时任务兜底取消
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Component
public class OrderTimeoutListener implements MessageListener {

    private final OrderService orderService;

    public OrderTimeoutListener(OrderService orderService) {
        this.orderService = orderService;
    }

    @Override
    public void onMessage(Message message, byte[] pattern) {
        String key = new String(message.getBody());
        if (!key.startsWith(RedisKeyConstant.ORDER_TIMEOUT_PREFIX)) {
            return;
        }
        String orderNo = key.substring(RedisKeyConstant.ORDER_TIMEOUT_PREFIX.length());
        orderService.cancelExpiredOrder(orderNo);
    }
}
