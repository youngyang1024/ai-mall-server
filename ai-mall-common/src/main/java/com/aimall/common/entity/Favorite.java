package com.aimall.common.entity;

import lombok.Data;
import java.time.LocalDateTime;

/**
 * 收藏/心愿单实体，对应表 t_favorite，记录用户收藏的 SPU
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class Favorite {
    private Long id;
    private Long userId;
    private Long spuId;
    private LocalDateTime createTime;
}
