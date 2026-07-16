package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceIssue;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单小类表 Mapper：查询已启用的工单小类列表及单条详情
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Mapper
public interface ServiceIssueMapper {

    List<ServiceIssue> selectEnabledList();

    ServiceIssue selectById(Long id);
}
