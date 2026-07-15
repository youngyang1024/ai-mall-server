package com.aimall.common.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * SPU 规格维度
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
