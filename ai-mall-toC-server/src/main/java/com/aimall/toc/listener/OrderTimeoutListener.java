package com.aimall.toc.listener;

import com.aimall.common.constant.RedisKeyConstant;
import com.aimall.toc.service.OrderService;
import org.springframework.data.redis.connection.Message;
import org.springframework.data.redis.connection.MessageListener;
import org.springframework.stereotype.Component;

/**
 * 监听 Redis Key 过期事件，自动取消超时未支付订单
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
