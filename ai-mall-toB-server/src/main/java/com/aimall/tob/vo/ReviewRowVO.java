package com.aimall.tob.vo;

import com.aimall.common.entity.ProductReview;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 评价列表查询行响应对象（JOIN t_spu / t_user 的结果）：继承 ProductReview 评价实体，扩展承载商品名称、用户名、昵称、头像字段，用于商家后台评价列表展示
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@EqualsAndHashCode(callSuper = true)
public class ReviewRowVO extends ProductReview {

    private String spuName;
    private String username;
    private String nickname;
    private String avatar;
}
