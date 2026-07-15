package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.RefundRejectDTO;
import com.aimall.tob.vo.RefundVO;

public interface RefundService {

    PageResult<RefundVO> list(Integer status, int pageNum, int pageSize);

    RefundVO detail(Long id);

    void approve(Long id);

    void reject(Long id, RefundRejectDTO dto);
}
