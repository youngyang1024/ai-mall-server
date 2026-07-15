package com.aimall.toc.mapper;

import com.aimall.common.entity.SpuSpec;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SpuSpecMapper {

    List<SpuSpec> selectBySpuId(@Param("spuId") Long spuId);
}
