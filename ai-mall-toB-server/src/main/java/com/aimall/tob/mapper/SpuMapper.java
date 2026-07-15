package com.aimall.tob.mapper;

import com.aimall.common.entity.Spu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SpuMapper {

    List<Spu> selectList(@Param("name") String name, @Param("categoryId") Long categoryId, @Param("status") Integer status);

    Spu selectById(@Param("id") Long id);

    int insert(Spu spu);

    int update(Spu spu);

    int updateStatus(@Param("id") Long id, @Param("status") Integer status);

    int deleteById(@Param("id") Long id);
}
