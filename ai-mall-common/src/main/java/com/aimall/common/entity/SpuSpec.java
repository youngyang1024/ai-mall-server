package com.aimall.common.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * SPU 规格维度实体，对应表 t_spu_spec，定义商品的规格名（如颜色、尺寸）及其可选值集合，用于生成 SKU 组合
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class SpuSpec {

    private Long id;
    private Long spuId;
    private String specName;
    private String specValues;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
}
