package com.aimall.tob.service.impl;

import cn.hutool.json.JSONUtil;
import com.aimall.common.entity.ProductReview;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ReviewVO;
import com.aimall.tob.mapper.ReviewMapper;
import com.aimall.tob.service.ReviewService;
import com.aimall.tob.vo.ReviewRowVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * B端商品评价管理服务实现，基于 ReviewMapper 按商品/评分/状态 PageHelper 分页查询，组装 VO 时解析图片 JSON 数组（Hutool JSONUtil）并优先展示真实用户名（nickname 兜底）；updateStatus 先校验评价存在再变更显示/隐藏状态
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class ReviewServiceImpl implements ReviewService {

    private final ReviewMapper reviewMapper;

    public ReviewServiceImpl(ReviewMapper reviewMapper) {
        this.reviewMapper = reviewMapper;
    }

    @Override
    public PageResult<ReviewVO> list(Long spuId, Integer rating, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<ReviewRowVO> rows = reviewMapper.selectList(spuId, rating, status);
        PageInfo<ReviewRowVO> pageInfo = new PageInfo<>(rows);
        List<ReviewVO> list = rows.stream().map(this::toVO).collect(Collectors.toList());
        return PageResult.of(list, pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public void updateStatus(Long id, Integer status) {
        ProductReview review = reviewMapper.selectById(id);
        if (review == null) {
            throw new BusinessException("评价不存在");
        }
        reviewMapper.updateStatus(id, status);
    }

    private ReviewVO toVO(ReviewRowVO row) {
        ReviewVO vo = new ReviewVO();
        vo.setId(row.getId());
        vo.setSpuId(row.getSpuId());
        vo.setUserId(row.getUserId());
        // B端展示真实用户名，nickname 为空时兜底
        vo.setNickname(StringUtils.hasText(row.getUsername()) ? row.getUsername() : row.getNickname());
        vo.setAvatar(row.getAvatar());
        vo.setRating(row.getRating());
        vo.setContent(row.getContent());
        vo.setImages(parseImages(row.getImages()));
        vo.setSkuSpec(row.getSkuSpec());
        vo.setStatus(row.getStatus());
        vo.setSpuName(row.getSpuName());
        vo.setCreateTime(row.getCreateTime());
        return vo;
    }

    private List<String> parseImages(String images) {
        if (!StringUtils.hasText(images)) {
            return Collections.emptyList();
        }
        return JSONUtil.toList(images, String.class);
    }
}
