package com.aimall.common.context;

/**
 * 当前登录用户上下文，基于 ThreadLocal 在同一请求线程内传递登录用户信息
 * <p>1. 登录拦截器解析 Token 成功后调用 set 写入 userId、username、userType
 * <p>2. 业务代码中通过 getUserId、getUsername、getUserType 获取当前登录用户信息，无需层层传参
 * <p>3. 请求结束时必须调用 clear 清理 ThreadLocal，防止线程池复用导致的用户信息串号与内存泄漏
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public final class UserContext {

    private static final ThreadLocal<Long> USER_ID = new ThreadLocal<>();
    private static final ThreadLocal<String> USERNAME = new ThreadLocal<>();
    private static final ThreadLocal<String> USER_TYPE = new ThreadLocal<>();

    private UserContext() {
    }

    public static void set(Long userId, String username, String userType) {
        USER_ID.set(userId);
        USERNAME.set(username);
        USER_TYPE.set(userType);
    }

    public static Long getUserId() {
        return USER_ID.get();
    }

    public static String getUsername() {
        return USERNAME.get();
    }

    public static String getUserType() {
        return USER_TYPE.get();
    }

    public static void clear() {
        USER_ID.remove();
        USERNAME.remove();
        USER_TYPE.remove();
    }
}
