package com.aimall.common.constant;

/**
 * Redis Key 常量类，统一管理登录 Token、订单超时等缓存 Key 的前缀与拼接规则，避免各模块散落硬编码
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public final class RedisKeyConstant {

    private RedisKeyConstant() {
    }

    /** Token 缓存前缀，完整 Key: token:{userType}:{userId} */
    public static final String TOKEN_PREFIX = "token:";

    /** 订单超时 Key 前缀，完整 Key: order:timeout:{orderNo} */
    public static final String ORDER_TIMEOUT_PREFIX = "order:timeout:";

    /** 用户类型：C端 */
    public static final String USER_TYPE_C = "c";

    /** 用户类型：B端 */
    public static final String USER_TYPE_B = "b";

    public static String tokenKey(String userType, Long userId) {
        return TOKEN_PREFIX + userType + ":" + userId;
    }

    public static String orderTimeoutKey(String orderNo) {
        return ORDER_TIMEOUT_PREFIX + orderNo;
    }
}
