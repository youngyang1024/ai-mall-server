package com.aimall.toc.service;

import com.aimall.common.entity.Category;
import com.aimall.common.entity.Spu;
import com.aimall.common.vo.PageResult;
import com.aimall.toc.vo.ProductDetailVO;

import java.util.List;

/**
 * C端商品分类服务接口：查询分类树
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface CategoryService {

    List<Category> tree();
}
