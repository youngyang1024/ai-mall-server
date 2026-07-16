package com.aimall.common.vo;

import lombok.Data;

import java.util.List;

/**
 * 分页结果封装对象，包含数据列表、总条数及分页参数（pageNum、pageSize），提供 of 静态工厂方法
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Data
public class PageResult<T> {

    private List<T> list;
    private long total;
    private int pageNum;
    private int pageSize;

    public static <T> PageResult<T> of(List<T> list, long total, int pageNum, int pageSize) {
        PageResult<T> result = new PageResult<>();
        result.setList(list);
        result.setTotal(total);
        result.setPageNum(pageNum);
        result.setPageSize(pageSize);
        return result;
    }
}
