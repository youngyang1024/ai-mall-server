package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.RefundRejectDTO;
import com.aimall.tob.vo.RefundVO;

/**
 * B端退款管理业务接口：定义退款单分页查询、详情查询、审批通过、驳回能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface RefundService {

    PageResult<RefundVO> list(Integer status, int pageNum, int pageSize);

    RefundVO detail(Long id);

    void approve(Long id);

    void reject(Long id, RefundRejectDTO dto);
}
