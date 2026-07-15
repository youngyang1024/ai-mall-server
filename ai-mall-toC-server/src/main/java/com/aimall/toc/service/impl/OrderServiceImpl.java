package com.aimall.toc.service.impl;

import com.aimall.common.constant.OrderStatus;
import com.aimall.common.constant.RedisKeyConstant;
import com.aimall.common.entity.*;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.util.RedisUtil;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.config.OrderProperties;
import com.aimall.toc.dto.OrderCreateDTO;
import com.aimall.toc.mapper.*;
import com.aimall.toc.service.OrderService;
import com.aimall.toc.vo.*;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Service
public class OrderServiceImpl implements OrderService {

    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final CartMapper cartMapper;
    private final SkuMapper skuMapper;
    private final SpuMapper spuMapper;
    private final UserAddressMapper userAddressMapper;
    private final UserCouponMapper userCouponMapper;
    private final CouponMapper couponMapper;
    private final RedisUtil redisUtil;
    private final OrderProperties orderProperties;
    private final ObjectMapper objectMapper;

    public OrderServiceImpl(OrderMapper orderMapper, OrderItemMapper orderItemMapper,
                            CartMapper cartMapper, SkuMapper skuMapper, SpuMapper spuMapper,
                            UserAddressMapper userAddressMapper, UserCouponMapper userCouponMapper,
                            CouponMapper couponMapper, RedisUtil redisUtil,
                            OrderProperties orderProperties, ObjectMapper objectMapper) {
        this.orderMapper = orderMapper;
        this.orderItemMapper = orderItemMapper;
        this.cartMapper = cartMapper;
        this.skuMapper = skuMapper;
        this.spuMapper = spuMapper;
        this.userAddressMapper = userAddressMapper;
        this.userCouponMapper = userCouponMapper;
        this.couponMapper = couponMapper;
        this.redisUtil = redisUtil;
        this.orderProperties = orderProperties;
        this.objectMapper = objectMapper;
    }

    /**
     * 创建订单
     *
     * 流程说明：
     * 1. 校验收货地址与购物车选中商品
     * 2. 校验库存并计算金额（含可选优惠券抵扣）
     * 3. 写入订单与明细、扣减库存、清理购物车
     * 4. 设置 Redis 支付超时 Key（30 分钟）
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public OrderCreateResultVO create(Long userId, OrderCreateDTO dto) {
        UserAddress address = userAddressMapper.selectById(dto.getAddressId());
        if (address == null || !address.getUserId().equals(userId)) {
            throw new BusinessException("收货地址不存在");
        }

        List<CartItemVO> selectedItems = resolveCartItems(userId, dto.getCartIds());
        if (selectedItems.isEmpty()) {
            throw new BusinessException("请选择要结算的商品");
        }

        BigDecimal totalAmount = BigDecimal.ZERO;
        for (CartItemVO item : selectedItems) {
            validateCartItem(item);
            totalAmount = totalAmount.add(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
        }

        Long userCouponId = dto.getUserCouponId();
        BigDecimal discountAmount = BigDecimal.ZERO;
        if (userCouponId != null) {
            discountAmount = calcCouponDiscount(userId, userCouponId, totalAmount);
        }

        BigDecimal payAmount = totalAmount.subtract(discountAmount);
        if (payAmount.compareTo(BigDecimal.ZERO) < 0) {
            payAmount = BigDecimal.ZERO;
        }

        String orderNo = generateOrderNo();
        String receiverInfo = buildReceiverInfo(address);

        Order order = new Order();
        order.setOrderNo(orderNo);
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setDiscountAmount(discountAmount);
        order.setPayAmount(payAmount);
        order.setCouponId(userCouponId);
        order.setStatus(OrderStatus.UNPAID.getCode());
        order.setReceiverInfo(receiverInfo);
        order.setRemark(dto.getRemark());
        orderMapper.insert(order);

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItemVO item : selectedItems) {
            int affected = skuMapper.deductStock(item.getSkuId(), item.getQuantity());
            if (affected == 0) {
                throw new BusinessException("商品「" + item.getSpuName() + "」库存不足");
            }
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(order.getId());
            orderItem.setSpuId(item.getSpuId());
            orderItem.setSkuId(item.getSkuId());
            orderItem.setSpuName(item.getSpuName());
            orderItem.setSkuSpec(item.getSkuSpec());
            orderItem.setImage(item.getImage());
            orderItem.setPrice(item.getPrice());
            orderItem.setQuantity(item.getQuantity());
            orderItems.add(orderItem);
        }
        orderItemMapper.batchInsert(orderItems);

        List<Long> cartIds = selectedItems.stream().map(CartItemVO::getId).collect(Collectors.toList());
        cartMapper.deleteByIds(userId, cartIds);

        redisUtil.set(RedisKeyConstant.orderTimeoutKey(orderNo), "1",
                orderProperties.getPayTimeoutMinutes(), TimeUnit.MINUTES);

        OrderCreateResultVO result = new OrderCreateResultVO();
        result.setOrderNo(orderNo);
        result.setPayAmount(payAmount);
        return result;
    }

    /**
     * 模拟支付
     *
     * 流程说明：
     * 1. 校验订单为待支付状态
     * 2. 更新为待发货并记录支付时间
     * 3. 标记优惠券已使用，删除 Redis 超时 Key
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void pay(Long userId, String orderNo) {
        Order order = requireUserOrder(userId, orderNo);
        if (order.getStatus() != OrderStatus.UNPAID.getCode()) {
            throw new BusinessException("订单状态不允许支付");
        }
        int affected = orderMapper.updatePaid(order.getId(), LocalDateTime.now());
        if (affected == 0) {
            throw new BusinessException("支付失败，请重试");
        }
        List<OrderItem> items = orderItemMapper.selectByOrderId(order.getId());
        for (OrderItem item : items) {
            spuMapper.incrementSalesCount(item.getSpuId(), item.getQuantity());
        }
        // 支付成功后标记优惠券已使用
        if (order.getCouponId() != null) {
            userCouponMapper.updateUsed(order.getCouponId(), LocalDateTime.now());
        }
        redisUtil.delete(RedisKeyConstant.orderTimeoutKey(orderNo));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancel(Long userId, String orderNo) {
        Order order = requireUserOrder(userId, orderNo);
        if (order.getStatus() != OrderStatus.UNPAID.getCode()) {
            throw new BusinessException("仅待支付订单可取消");
        }
        doCancelUnpaid(order);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void confirm(Long userId, String orderNo) {
        Order order = requireUserOrder(userId, orderNo);
        if (order.getStatus() != OrderStatus.SHIPPED.getCode()) {
            throw new BusinessException("仅已发货订单可确认收货");
        }
        int affected = orderMapper.updateCompleted(order.getId(), LocalDateTime.now());
        if (affected == 0) {
            throw new BusinessException("确认收货失败，请重试");
        }
    }

    /**
     * 超时取消未支付订单（幂等）
     *
     * 流程说明：
     * 1. 仅处理待支付订单
     * 2. 更新为已取消并回滚库存
     * 3. 删除 Redis 超时 Key
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void cancelExpiredOrder(String orderNo) {
        Order order = orderMapper.selectByOrderNo(orderNo);
        if (order == null || order.getStatus() != OrderStatus.UNPAID.getCode()) {
            return;
        }
        doCancelUnpaid(order);
    }

    @Override
    public PageResult<OrderVO> list(Long userId, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Order> orders = orderMapper.selectByUserId(userId, status);
        PageInfo<Order> pageInfo = new PageInfo<>(orders);
        List<OrderVO> list = orders.stream().map(this::toSummaryVO).collect(Collectors.toList());
        return PageResult.of(list, pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public OrderVO detail(Long userId, String orderNo) {
        Order order = requireUserOrder(userId, orderNo);
        OrderVO vo = toDetailVO(order);
        List<OrderItem> items = orderItemMapper.selectByOrderId(order.getId());
        vo.setItems(items.stream().map(this::toItemVO).collect(Collectors.toList()));
        return vo;
    }

    private void doCancelUnpaid(Order order) {
        int affected = orderMapper.updateStatus(order.getId(),
                OrderStatus.UNPAID.getCode(), OrderStatus.CANCELLED.getCode());
        if (affected == 0) {
            return;
        }
        List<OrderItem> items = orderItemMapper.selectByOrderId(order.getId());
        for (OrderItem item : items) {
            skuMapper.restoreStock(item.getSkuId(), item.getQuantity());
        }
        redisUtil.delete(RedisKeyConstant.orderTimeoutKey(order.getOrderNo()));
    }

    private List<CartItemVO> resolveCartItems(Long userId, List<Long> cartIds) {
        List<CartItemVO> all = cartMapper.selectByUserId(userId);
        if (cartIds != null && !cartIds.isEmpty()) {
            Set<Long> idSet = new HashSet<>(cartIds);
            return all.stream().filter(item -> idSet.contains(item.getId())).collect(Collectors.toList());
        }
        return all.stream().filter(item -> item.getChecked() != null && item.getChecked() == 1)
                .collect(Collectors.toList());
    }

    private void validateCartItem(CartItemVO item) {
        if (item.getSpuStatus() == null || item.getSpuStatus() != 1) {
            throw new BusinessException("商品「" + item.getSpuName() + "」已下架");
        }
        Sku sku = skuMapper.selectById(item.getSkuId());
        if (sku == null) {
            throw new BusinessException("商品规格不存在");
        }
        if (item.getQuantity() > sku.getStock()) {
            throw new BusinessException("商品「" + item.getSpuName() + "」库存不足");
        }
        Spu spu = spuMapper.selectOnShelfById(item.getSpuId());
        if (spu == null) {
            throw new BusinessException("商品「" + item.getSpuName() + "」已下架");
        }
    }

    private BigDecimal calcCouponDiscount(Long userId, Long userCouponId, BigDecimal totalAmount) {
        UserCoupon userCoupon = userCouponMapper.selectByIdAndUserId(userCouponId, userId);
        if (userCoupon == null || userCoupon.getStatus() != 0) {
            throw new BusinessException("优惠券不可用");
        }
        Coupon coupon = couponMapper.selectById(userCoupon.getCouponId());
        if (coupon == null || coupon.getStatus() != 1) {
            throw new BusinessException("优惠券已失效");
        }
        LocalDateTime now = LocalDateTime.now();
        if (now.isBefore(coupon.getStartTime()) || now.isAfter(coupon.getEndTime())) {
            throw new BusinessException("优惠券已过期");
        }
        if (totalAmount.compareTo(coupon.getThreshold()) < 0) {
            throw new BusinessException("未达到优惠券使用门槛");
        }
        return coupon.getDiscount();
    }

    private String buildReceiverInfo(UserAddress address) {
        try {
            Map<String, String> info = new LinkedHashMap<>();
            info.put("receiverName", address.getReceiverName());
            info.put("receiverPhone", address.getReceiverPhone());
            info.put("province", address.getProvince());
            info.put("city", address.getCity());
            info.put("district", address.getDistrict());
            info.put("detail", address.getDetail());
            return objectMapper.writeValueAsString(info);
        } catch (Exception e) {
            throw new BusinessException("地址信息处理失败");
        }
    }

    private Order requireUserOrder(Long userId, String orderNo) {
        Order order = orderMapper.selectByOrderNoAndUserId(orderNo, userId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        return order;
    }

    private String generateOrderNo() {
        return "ORD" + System.currentTimeMillis()
                + String.format("%04d", ThreadLocalRandom.current().nextInt(10000));
    }

    private OrderVO toSummaryVO(Order order) {
        OrderVO vo = new OrderVO();
        BeanUtils.copyProperties(order, vo);
        vo.setStatusDesc(OrderStatus.of(order.getStatus()).getDesc());
        return vo;
    }

    private OrderVO toDetailVO(Order order) {
        return toSummaryVO(order);
    }

    private OrderItemVO toItemVO(OrderItem item) {
        OrderItemVO vo = new OrderItemVO();
        BeanUtils.copyProperties(item, vo);
        return vo;
    }
}
