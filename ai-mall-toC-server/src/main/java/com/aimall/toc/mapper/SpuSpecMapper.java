package com.aimall.toc.mapper;

import com.aimall.common.entity.SpuSpec;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * SPU 规格表 Mapper：按 SPU 查询商品规格列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface SpuSpecMapper {

    List<SpuSpec> selectBySpuId(@Param("spuId") Long spuId);
}
