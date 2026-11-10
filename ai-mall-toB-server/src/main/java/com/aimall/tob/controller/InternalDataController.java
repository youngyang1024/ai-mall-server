package com.aimall.tob.controller;

import com.aimall.common.entity.FaqArticle;
import com.aimall.common.result.Result;
import com.aimall.tob.mapper.InternalDataMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 内部只读数据接口，供 ai-mall-agent-server 同步知识库使用（服务间调用，不对公网暴露）
 *
 * <p>1. 鉴权：X-Internal-Token 请求头与配置 aimall.internal-token 比对，不走 admin 登录态
 * <p>2. FAQ：返回启用状态文章，支持按 update_time 增量拉取
 * <p>3. 商品：返回上架 SPU 及其 SKU 规格摘要（供构造商品知识库文档），支持增量拉取
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@RestController
@RequestMapping("/admin/internal")
public class InternalDataController {

    private final InternalDataMapper internalDataMapper;

    @Value("${aimall.internal-token:}")
    private String internalToken;

    public InternalDataController(InternalDataMapper internalDataMapper) {
        this.internalDataMapper = internalDataMapper;
    }

    /**
     * FAQ 列表（含禁用状态，由同步侧按 status 过滤/打元数据），updatedSince 为空则全量
     */
    @GetMapping("/faq/list")
    public Result<List<FaqArticle>> faqList(@RequestHeader(value = "X-Internal-Token", required = false) String token,
                                            @RequestParam(required = false) String updatedSince) {
        checkToken(token);
        return Result.success(internalDataMapper.selectFaqList(parseTime(updatedSince)));
    }

    /**
     * 商品列表（SPU + 规格摘要 + 价格区间），updatedSince 为空则全量
     */
    @GetMapping("/product/list")
    public Result<List<Map<String, Object>>> productList(@RequestHeader(value = "X-Internal-Token", required = false) String token,
                                                         @RequestParam(required = false) String updatedSince) {
        checkToken(token);
        return Result.success(internalDataMapper.selectProductList(parseTime(updatedSince)));
    }

    private void checkToken(String token) {
        if (!StringUtils.hasText(internalToken) || !internalToken.equals(token)) {
            throw new IllegalArgumentException("内部接口鉴权失败");
        }
    }

    private LocalDateTime parseTime(String updatedSince) {
        return StringUtils.hasText(updatedSince) ? LocalDateTime.parse(updatedSince) : null;
    }
}
