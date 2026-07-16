package com.aimall.toc.mapper;

import com.aimall.common.entity.SpuImage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * SPU 图片表 Mapper：按 SPU 查询商品图片列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface SpuImageMapper {

    List<SpuImage> selectBySpuId(@Param("spuId") Long spuId);
}
