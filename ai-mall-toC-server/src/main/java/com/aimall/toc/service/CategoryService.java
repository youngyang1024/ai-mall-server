package com.aimall.toc.service;

import com.aimall.common.entity.Category;
import com.aimall.common.entity.Spu;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.vo.ProductDetailVO;

import java.util.List;

public interface CategoryService {

    List<Category> tree();
}
