package com.aimall.agent.service;

import org.springframework.stereotype.Service;
import reactor.core.Disposable;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * 生成停止信号注册表：支持 /agent/chat/stop 中断进行中的流式生成
 *
 * <p>1. 每条 assistant 消息生成前注册停止标记；stop 时置标记并 dispose 上游 LLM 订阅（立即停止 token 消耗，而非仅停止转发）
 * <p>2. 单实例内存实现（与 SimpleVectorStore 同前提）；多实例部署时需改为 Redis 标记
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Service
public class ChatStopRegistry {

    private final Map<String, AtomicBoolean> stopFlags = new ConcurrentHashMap<>();

    private final Map<String, Disposable> upstreams = new ConcurrentHashMap<>();

    /** 生成开始前注册 */
    public void register(String messageId) {
        stopFlags.put(messageId, new AtomicBoolean(false));
    }

    /** 绑定上游 LLM 订阅（订阅创建后调用），stop 时用于掐断流 */
    public void bindUpstream(String messageId, Disposable disposable) {
        if (stopFlags.containsKey(messageId)) {
            upstreams.put(messageId, disposable);
            // 竞态兜底：绑定前已收到停止请求，立即掐断
            if (isStopRequested(messageId)) {
                disposable.dispose();
            }
        }
    }

    /** 请求停止：置标记并掐断上游流；消息不存在或已结束返回 false */
    public boolean requestStop(String messageId) {
        AtomicBoolean flag = stopFlags.get(messageId);
        if (flag == null) {
            return false;
        }
        flag.set(true);
        Disposable upstream = upstreams.get(messageId);
        if (upstream != null) {
            upstream.dispose();
        }
        return true;
    }

    public boolean isStopRequested(String messageId) {
        AtomicBoolean flag = stopFlags.get(messageId);
        return flag != null && flag.get();
    }

    /** 生成结束后清理 */
    public void unregister(String messageId) {
        stopFlags.remove(messageId);
        upstreams.remove(messageId);
    }
}
