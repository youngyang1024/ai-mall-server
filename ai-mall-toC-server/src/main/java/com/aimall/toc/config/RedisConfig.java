package com.aimall.toc.config;

import com.aimall.toc.listener.OrderTimeoutListener;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.listener.PatternTopic;
import org.springframework.data.redis.listener.RedisMessageListenerContainer;

/**
 * Redis 消息监听配置，为订单超时自动取消机制提供事件通道
 *
 * <p>1. 注册 RedisMessageListenerContainer 消息监听容器
 * <p>2. 将 OrderTimeoutListener 订阅到 __keyevent@0__:expired 主题（db0 的 key 过期事件），下单时写入的支付超时 key 过期后触发订单自动取消
 * <p>3. 依赖 Redis 服务端开启 notify-keyspace-events 过期事件通知；事件不保证可靠送达，由 OrderTimeoutScheduleTask 定时扫描兜底
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Configuration
public class RedisConfig {

    @Bean
    public RedisMessageListenerContainer redisMessageListenerContainer(
            RedisConnectionFactory connectionFactory,
            OrderTimeoutListener orderTimeoutListener) {
        RedisMessageListenerContainer container = new RedisMessageListenerContainer();
        container.setConnectionFactory(connectionFactory);
        container.addMessageListener(orderTimeoutListener, new PatternTopic("__keyevent@0__:expired"));
        return container;
    }
}
