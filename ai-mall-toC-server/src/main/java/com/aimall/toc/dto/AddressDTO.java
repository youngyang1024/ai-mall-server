package com.aimall.toc.dto;

import io.swagger.annotations.ApiModel;
import lombok.Data;

import javax.validation.constraints.NotBlank;

/**
 * 收货地址新增/编辑请求 DTO：收货人、联系电话、省市区及详细地址
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
@ApiModel("收货地址请求")
public class AddressDTO {
    private Long id;
    @NotBlank(message = "收货人不能为空")
    private String receiverName;
    @NotBlank(message = "收货电话不能为空")
    private String receiverPhone;
    private String province;
    private String city;
    private String district;
    @NotBlank(message = "详细地址不能为空")
    private String detail;
    private Integer isDefault;
}
