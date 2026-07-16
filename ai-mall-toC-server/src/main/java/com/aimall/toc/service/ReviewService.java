package com.aimall.toc.service;

import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ReviewSummaryVO;
import com.aimall.common.vo.ReviewVO;
import com.aimall.toc.dto.ReviewCreateDTO;
import com.aimall.toc.vo.PendingReviewVO;

/**
 * C端商品评价服务接口：发表评价/商品评价列表/评价汇总统计/待评价列表/我的评价
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface ReviewService {

    void create(Long userId, ReviewCreateDTO dto);

    PageResult<ReviewVO> listBySpu(Long spuId, Integer rating, int pageNum, int pageSize);

    ReviewSummaryVO summary(Long spuId);

    PageResult<PendingReviewVO> pending(Long userId, int pageNum, int pageSize);

    PageResult<ReviewVO> myReviews(Long userId, int pageNum, int pageSize);
}
