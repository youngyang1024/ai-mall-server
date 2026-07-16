package com.aimall.toc.service.impl;

import cn.hutool.json.JSONUtil;
import com.aimall.common.constant.OrderStatus;
import com.aimall.common.entity.Order;
import com.aimall.common.entity.OrderItem;
import com.aimall.common.entity.ProductReview;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ReviewSummaryVO;
import com.aimall.common.vo.ReviewVO;
import com.aimall.toc.dto.ReviewCreateDTO;
import com.aimall.toc.mapper.OrderItemMapper;
import com.aimall.toc.mapper.OrderMapper;
import com.aimall.toc.mapper.ProductReviewMapper;
import com.aimall.toc.service.ReviewService;
import com.aimall.toc.vo.PendingReviewVO;
import com.aimall.toc.vo.ReviewRowVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * C端商品评价服务，负责评价发表、商品评价列表/汇总查询及用户待评价、已评价列表
 *
 * <p>1. 发表评价前校验：订单项存在、订单归属当前用户且状态为已完成，才允许评价
 * <p>2. 防重复评价：先按订单项查重，插入时再捕获唯一键冲突（DuplicateKeyException）兜底，评价内容从订单项快照 spuId/skuId/skuSpec，晒图列表 JSON 序列化存储
 * <p>3. 评价列表查询支持按评分筛选，输出时对用户昵称脱敏（保留首尾字符、中间以 *** 替代）
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class ReviewServiceImpl implements ReviewService {

    private final ProductReviewMapper productReviewMapper;
    private final OrderItemMapper orderItemMapper;
    private final OrderMapper orderMapper;

    public ReviewServiceImpl(ProductReviewMapper productReviewMapper,
                             OrderItemMapper orderItemMapper, OrderMapper orderMapper) {
        this.productReviewMapper = productReviewMapper;
        this.orderItemMapper = orderItemMapper;
        this.orderMapper = orderMapper;
    }

    /**
     * 发表评价
     *
     * 流程说明：
     * 1. 校验订单项存在且订单属于当前用户、状态为已完成
     * 2. 校验该订单项未评价过（先查重，再兜底捕获唯一键冲突）
     * 3. 从订单项快照 spuId/skuId/skuSpec，晒图 JSON 序列化存储
     */
    @Override
    public void create(Long userId, ReviewCreateDTO dto) {
        OrderItem orderItem = orderItemMapper.selectById(dto.getOrderItemId());
        if (orderItem == null) {
            throw new BusinessException("订单项不存在");
        }
        Order order = orderMapper.selectById(orderItem.getOrderId());
        if (order == null || !order.getUserId().equals(userId)) {
            throw new BusinessException("订单项不存在");
        }
        if (order.getStatus() != OrderStatus.COMPLETED.getCode()) {
            throw new BusinessException("订单完成后才能评价");
        }
        if (productReviewMapper.selectByOrderItemId(dto.getOrderItemId()) != null) {
            throw new BusinessException("该商品已评价过");
        }

        ProductReview review = new ProductReview();
        review.setOrderId(order.getId());
        review.setOrderItemId(orderItem.getId());
        review.setSpuId(orderItem.getSpuId());
        review.setSkuId(orderItem.getSkuId());
        review.setUserId(userId);
        review.setRating(dto.getRating());
        review.setContent(dto.getContent());
        if (dto.getImages() != null && !dto.getImages().isEmpty()) {
            review.setImages(JSONUtil.toJsonStr(dto.getImages()));
        }
        review.setSkuSpec(orderItem.getSkuSpec());
        review.setStatus(1);
        try {
            productReviewMapper.insert(review);
        } catch (DuplicateKeyException e) {
            throw new BusinessException("该商品已评价过");
        }
    }

    @Override
    public PageResult<ReviewVO> listBySpu(Long spuId, Integer rating, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<ReviewRowVO> rows = productReviewMapper.selectBySpuId(spuId, rating);
        PageInfo<ReviewRowVO> pageInfo = new PageInfo<>(rows);
        List<ReviewVO> list = rows.stream().map(this::toVO).collect(Collectors.toList());
        return PageResult.of(list, pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public ReviewSummaryVO summary(Long spuId) {
        return productReviewMapper.selectSummaryBySpuId(spuId);
    }

    @Override
    public PageResult<PendingReviewVO> pending(Long userId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<PendingReviewVO> list = productReviewMapper.selectPendingByUserId(userId);
        PageInfo<PendingReviewVO> pageInfo = new PageInfo<>(list);
        return PageResult.of(pageInfo.getList(), pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public PageResult<ReviewVO> myReviews(Long userId, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<ReviewRowVO> rows = productReviewMapper.selectByUserId(userId);
        PageInfo<ReviewRowVO> pageInfo = new PageInfo<>(rows);
        List<ReviewVO> list = rows.stream().map(this::toVO).collect(Collectors.toList());
        return PageResult.of(list, pageInfo.getTotal(), pageNum, pageSize);
    }

    private ReviewVO toVO(ReviewRowVO row) {
        ReviewVO vo = new ReviewVO();
        vo.setId(row.getId());
        vo.setSpuId(row.getSpuId());
        vo.setUserId(row.getUserId());
        vo.setNickname(maskNickname(row.getNickname()));
        vo.setAvatar(row.getAvatar());
        vo.setRating(row.getRating());
        vo.setContent(row.getContent());
        vo.setImages(parseImages(row.getImages()));
        vo.setSkuSpec(row.getSkuSpec());
        vo.setStatus(row.getStatus());
        vo.setSpuName(row.getSpuName());
        vo.setSpuImage(row.getSpuImage());
        vo.setCreateTime(row.getCreateTime());
        return vo;
    }

    private List<String> parseImages(String images) {
        if (!StringUtils.hasText(images)) {
            return Collections.emptyList();
        }
        return JSONUtil.toList(images, String.class);
    }

    /**
     * 昵称脱敏：保留首尾字符，中间补 ***；1-2 字符则首字符 + ***
     */
    private String maskNickname(String nickname) {
        if (!StringUtils.hasText(nickname)) {
            return "***";
        }
        if (nickname.length() <= 2) {
            return nickname.charAt(0) + "***";
        }
        return nickname.charAt(0) + "***" + nickname.charAt(nickname.length() - 1);
    }
}
