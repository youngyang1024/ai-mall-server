package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceCategory;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单大类表 Mapper：查询已启用的工单大类列表
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface ServiceCategoryMapper {

    List<ServiceCategory> selectEnabledList();
}
