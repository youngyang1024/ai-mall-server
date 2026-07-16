package com.aimall.tob.mapper;

import com.aimall.common.entity.SpuImage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_spu_image 表数据访问，提供 SPU 图片按 SPU ID 查询、新增、删除等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface SpuImageMapper {

    List<SpuImage> selectBySpuId(@Param("spuId") Long spuId);

    int insert(SpuImage spuImage);

    int deleteBySpuId(@Param("spuId") Long spuId);
}
