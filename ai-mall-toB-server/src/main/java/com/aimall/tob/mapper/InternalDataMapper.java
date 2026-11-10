package com.aimall.tob.mapper;

import com.aimall.common.entity.FaqArticle;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 内部数据同步查询，供 InternalDataController 输出给 agent-server 构造知识库
 *
 * <p>1. FAQ：全量或按 update_time 增量（含禁用状态，由同步侧打元数据后在检索时过滤）
 * <p>2. 商品：SPU 基础信息 + 聚合的 SKU 规格/价格区间/总库存（GROUP_CONCAT 规格摘要）
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Mapper
public interface InternalDataMapper {

    List<FaqArticle> selectFaqList(@Param("updatedSince") LocalDateTime updatedSince);

    List<Map<String, Object>> selectProductList(@Param("updatedSince") LocalDateTime updatedSince);
}
