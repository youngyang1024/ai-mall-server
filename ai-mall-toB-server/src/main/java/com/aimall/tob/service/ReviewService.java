package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.common.vo.ReviewVO;

/**
 * B端商品评价管理业务接口：定义评价分页查询（支持按商品、评分、状态筛选）、审核状态变更能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface ReviewService {

    PageResult<ReviewVO> list(Long spuId, Integer rating, Integer status, int pageNum, int pageSize);

    void updateStatus(Long id, Integer status);
}
