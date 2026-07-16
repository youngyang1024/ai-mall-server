package com.aimall.toc.mapper;

import com.aimall.common.entity.ProductReview;
import com.aimall.common.vo.ReviewSummaryVO;
import com.aimall.toc.vo.PendingReviewVO;
import com.aimall.toc.vo.ReviewRowVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 商品评价表 Mapper：评价的新增、按 SPU/用户查询、评分汇总统计及待评价订单项查询
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface ProductReviewMapper {

    int insert(ProductReview review);

    ProductReview selectByOrderItemId(@Param("orderItemId") Long orderItemId);

    List<ReviewRowVO> selectBySpuId(@Param("spuId") Long spuId, @Param("rating") Integer rating);

    ReviewSummaryVO selectSummaryBySpuId(@Param("spuId") Long spuId);

    List<PendingReviewVO> selectPendingByUserId(@Param("userId") Long userId);

    List<ReviewRowVO> selectByUserId(@Param("userId") Long userId);
}
