package com.aimall.agent.context;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 会话身份主体：登录用户（userId）或游客（eid），二者必有其一
 *
 * <p>1. 由认证拦截器解析请求后写入 ThreadLocal，请求结束清理
 * <p>2. 工具层身份类操作（加购/查订单/开工单）必须校验 isLogin，游客一律拒绝并引导登录
 * <p>3. principalKey 用于限额计数与短期记忆的 Redis key 维度
 *
 * @author
 * Created by Yang on 2026/07/26
 */
public class ChatPrincipalContext {

    private static final ThreadLocal<ChatPrincipal> HOLDER = new ThreadLocal<>();

    public static void set(ChatPrincipal principal) {
        HOLDER.set(principal);
    }

    public static ChatPrincipal get() {
        return HOLDER.get();
    }

    public static void clear() {
        HOLDER.remove();
    }

    /**
     * 身份主体
     */
    @Getter
    @AllArgsConstructor
    public static class ChatPrincipal {

        /** 用户ID(游客为空) */
        private final Long userId;

        /** 游客标识(登录用户为空) */
        private final String eid;

        /** 用户名(游客为空) */
        private final String username;

        public boolean isLogin() {
            return userId != null;
        }

        /** 限额/记忆等 Redis key 的身份维度：登录用 u:{userId}，游客用 g:{eid} */
        public String principalKey() {
            return isLogin() ? "u:" + userId : "g:" + eid;
        }
    }
}
