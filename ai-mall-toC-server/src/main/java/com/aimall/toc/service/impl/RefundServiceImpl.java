package com.aimall.toc.service.impl;

import com.aimall.common.constant.OrderStatus;
import com.aimall.common.constant.RefundStatus;
import com.aimall.common.entity.Order;
import com.aimall.common.entity.Refund;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.dto.RefundApplyDTO;
import com.aimall.toc.mapper.OrderMapper;
import com.aimall.toc.mapper.RefundMapper;
import com.aimall.toc.service.RefundService;
import com.aimall.toc.vo.RefundVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

/**
 * C端退款服务，负责退款申请及用户退款单列表、详情查询
 *
 * <p>1. 申请退款校验：订单归属当前用户，且状态为待发货或已发货，同一订单不允许存在多个待审核的退款申请
 * <p>2. 创建退款单：按订单实付金额生成退款单（状态置为待审核），并记录申请前的订单状态（orderStatusBefore），供审核驳回时恢复
 * <p>3. 订单状态流转：通过带原状态条件的 UPDATE 将订单置为退款中，更新失败则整体回滚，防止并发状态冲突
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class RefundServiceImpl implements RefundService {

    private final RefundMapper refundMapper;
    private final OrderMapper orderMapper;

    public RefundServiceImpl(RefundMapper refundMapper, OrderMapper orderMapper) {
        this.refundMapper = refundMapper;
        this.orderMapper = orderMapper;
    }

    /**
     * 申请退款
     *
     * 流程说明：
     * 1. 校验订单属于当前用户且状态为待发货/已发货
     * 2. 创建退款单并将订单置为退款中
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void apply(Long userId, RefundApplyDTO dto) {
        Order order = orderMapper.selectByOrderNoAndUserId(dto.getOrderNo(), userId);
        if (order == null) {
            throw new BusinessException("订单不存在");
        }
        int status = order.getStatus();
        if (status != OrderStatus.PAID.getCode() && status != OrderStatus.SHIPPED.getCode()) {
            throw new BusinessException("当前订单状态不允许申请退款");
        }
        if (refundMapper.countPendingByOrderId(order.getId()) > 0) {
            throw new BusinessException("该订单已有待审核的退款申请");
        }

        Refund refund = new Refund();
        refund.setRefundNo(generateRefundNo());
        refund.setOrderId(order.getId());
        refund.setUserId(userId);
        refund.setRefundAmount(order.getPayAmount());
        refund.setReason(dto.getReason());
        refund.setStatus(RefundStatus.PENDING.getCode());
        refund.setOrderStatusBefore(status);
        refundMapper.insert(refund);

        int affected = orderMapper.updateStatus(order.getId(), status, OrderStatus.REFUNDING.getCode());
        if (affected == 0) {
            throw new BusinessException("申请退款失败，请重试");
        }
    }

    @Override
    public PageResult<RefundVO> list(Long userId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Refund> refunds = refundMapper.selectByUserId(userId);
        PageInfo<Refund> pageInfo = new PageInfo<>(refunds);
        List<RefundVO> list = refunds.stream().map(this::toVO).collect(Collectors.toList());
        return PageResult.of(list, pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public RefundVO detail(Long userId, Long id) {
        Refund refund = refundMapper.selectByIdAndUserId(id, userId);
        if (refund == null) {
            throw new BusinessException("退款记录不存在");
        }
        return toVO(refund);
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

    private String generateRefundNo() {
        return "REF" + System.currentTimeMillis()
                + String.format("%04d", ThreadLocalRandom.current().nextInt(10000));
    }
}
