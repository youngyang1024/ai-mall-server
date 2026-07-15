package com.aimall.toc.mapper;

import com.aimall.common.entity.SpuImage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SpuImageMapper {

    List<SpuImage> selectBySpuId(@Param("spuId") Long spuId);
}
