package com.aimall.toc.service;

import com.aimall.common.vo.PageResult;
import com.aimall.toc.dto.RefundApplyDTO;
import com.aimall.toc.vo.RefundVO;

public interface RefundService {

    void apply(Long userId, RefundApplyDTO dto);

    PageResult<RefundVO> list(Long userId, int pageNum, int pageSize);

    RefundVO detail(Long userId, Long id);
}
