package com.aimall.tob.service.impl;

import com.aimall.common.constant.OrderStatus;
import com.aimall.common.constant.RefundStatus;
import com.aimall.common.entity.Order;
import com.aimall.common.entity.OrderItem;
import com.aimall.common.entity.Refund;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.RefundRejectDTO;
import com.aimall.tob.mapper.OrderItemMapper;
import com.aimall.tob.mapper.OrderMapper;
import com.aimall.tob.mapper.RefundMapper;
import com.aimall.tob.mapper.SkuMapper;
import com.aimall.tob.service.RefundService;
import com.aimall.tob.vo.RefundVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

/**
 * B端退款审核服务实现，退款单状态机流转（待审核 -> 已通过/已拒绝）
 * <p>1. 审核通过：以条件更新（WHERE status = 待审核）将退款单置为已通过，再将订单从退款中置为已退款，最后查询订单全部 OrderItem 明细，逐条按购买数量回滚对应 SKU 库存（stock = stock + quantity）
 * <p>2. 审核拒绝：以条件更新写入拒绝原因并将退款单置为已拒绝，同时依据退款单上快照的 orderStatusBefore，将订单从退款中恢复为申请退款前的状态
 * <p>3. 两个审核操作均在事务内执行（rollbackFor = Exception.class），任一条件更新影响行数为 0 即视为状态已变更或并发冲突，抛出 BusinessException 整体回滚
 * <p>4. 列表/详情基于 PageHelper 分页，组装 VO 时回查订单补充订单号；依赖 RefundMapper、OrderMapper、OrderItemMapper、SkuMapper
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class RefundServiceImpl implements RefundService {

    private final RefundMapper refundMapper;
    private final OrderMapper orderMapper;
    private final OrderItemMapper orderItemMapper;
    private final SkuMapper skuMapper;

    public RefundServiceImpl(RefundMapper refundMapper, OrderMapper orderMapper,
                             OrderItemMapper orderItemMapper, SkuMapper skuMapper) {
        this.refundMapper = refundMapper;
        this.orderMapper = orderMapper;
        this.orderItemMapper = orderItemMapper;
        this.skuMapper = skuMapper;
    }

    @Override
    public PageResult<RefundVO> list(Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Refund> refunds = refundMapper.selectList(status);
        PageInfo<Refund> pageInfo = new PageInfo<>(refunds);
        List<RefundVO> list = refunds.stream().map(this::toVO).collect(Collectors.toList());
        return PageResult.of(list, pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public RefundVO detail(Long id) {
        Refund refund = requireRefund(id);
        return toVO(refund);
    }

    /**
     * 审核通过退款：订单置为已退款，并回滚库存
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void approve(Long id) {
        Refund refund = requirePendingRefund(id);
        int affected = refundMapper.updateApproved(id);
        if (affected == 0) {
            throw new BusinessException("审核失败，请重试");
        }
        int orderAffected = orderMapper.updateToRefunded(refund.getOrderId());
        if (orderAffected == 0) {
            throw new BusinessException("订单状态更新失败");
        }
        restoreStock(refund.getOrderId());
    }

    /**
     * 拒绝退款：恢复申请前订单状态
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void reject(Long id, RefundRejectDTO dto) {
        Refund refund = requirePendingRefund(id);
        int affected = refundMapper.updateRejected(id, dto.getRejectReason());
        if (affected == 0) {
            throw new BusinessException("操作失败，请重试");
        }
        int orderAffected = orderMapper.updateStatus(refund.getOrderId(),
                OrderStatus.REFUNDING.getCode(), refund.getOrderStatusBefore());
        if (orderAffected == 0) {
            throw new BusinessException("订单状态恢复失败");
        }
    }

    private Refund requireRefund(Long id) {
        Refund refund = refundMapper.selectById(id);
        if (refund == null) {
            throw new BusinessException("退款记录不存在");
        }
        return refund;
    }

    private Refund requirePendingRefund(Long id) {
        Refund refund = requireRefund(id);
        if (refund.getStatus() != RefundStatus.PENDING.getCode()) {
            throw new BusinessException("仅待审核退款可处理");
        }
        return refund;
    }

    private void restoreStock(Long orderId) {
        List<OrderItem> items = orderItemMapper.selectByOrderId(orderId);
        for (OrderItem item : items) {
            skuMapper.restoreStock(item.getSkuId(), item.getQuantity());
        }
    }

    private RefundVO toVO(Refund refund) {
        RefundVO vo = new RefundVO();
        BeanUtils.copyProperties(refund, vo);
        vo.setStatusDesc(RefundStatus.values()[refund.getStatus()].getDesc());
        Order order = orderMapper.selectById(refund.getOrderId());
        if (order != null) {
            vo.setOrderNo(order.getOrderNo());
        }
        return vo;
    }
}
