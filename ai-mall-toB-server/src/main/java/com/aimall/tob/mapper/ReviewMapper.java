package com.aimall.tob.mapper;

import com.aimall.common.entity.ProductReview;
import com.aimall.tob.vo.ReviewRowVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_product_review 表数据访问（关联 t_spu、t_user），提供商品评价条件列表查询、审核状态更新等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface ReviewMapper {

    List<ReviewRowVO> selectList(@Param("spuId") Long spuId, @Param("rating") Integer rating,
                                 @Param("status") Integer status);

    ProductReview selectById(@Param("id") Long id);

    int updateStatus(@Param("id") Long id, @Param("status") Integer status);
}
