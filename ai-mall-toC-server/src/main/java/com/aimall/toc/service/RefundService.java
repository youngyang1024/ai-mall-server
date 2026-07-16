package com.aimall.toc.service;

import com.aimall.common.vo.PageResult;
import com.aimall.toc.dto.RefundApplyDTO;
import com.aimall.toc.vo.RefundVO;

/**
 * C端售后退款服务接口：申请退款/退款单分页列表/退款单详情
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface RefundService {

    void apply(Long userId, RefundApplyDTO dto);

    PageResult<RefundVO> list(Long userId, int pageNum, int pageSize);

    RefundVO detail(Long userId, Long id);
}
