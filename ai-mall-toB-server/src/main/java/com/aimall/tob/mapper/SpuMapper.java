package com.aimall.tob.mapper;

import com.aimall.common.entity.Spu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_spu 表数据访问（关联 t_category），提供商品 SPU 条件列表查询、新增、更新、上下架状态更新、删除等操作
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface SpuMapper {

    List<Spu> selectList(@Param("id") Long id, @Param("name") String name, @Param("categoryId") Long categoryId, @Param("status") Integer status);

    Spu selectById(@Param("id") Long id);

    int insert(Spu spu);

    int update(Spu spu);

    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    int deleteById(@Param("id") Long id);
}
