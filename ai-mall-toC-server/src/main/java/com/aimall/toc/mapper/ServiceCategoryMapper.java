package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceCategory;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单大类 Mapper
 */
@Mapper
public interface ServiceCategoryMapper {

    List<ServiceCategory> selectEnabledList();
}
