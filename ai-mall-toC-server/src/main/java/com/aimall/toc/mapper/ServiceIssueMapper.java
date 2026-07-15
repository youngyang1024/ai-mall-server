package com.aimall.toc.mapper;

import com.aimall.common.entity.ServiceIssue;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 服务工单小类 Mapper
 */
@Mapper
public interface ServiceIssueMapper {

    List<ServiceIssue> selectEnabledList();

    ServiceIssue selectById(Long id);
}
