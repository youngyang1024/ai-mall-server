package com.aimall.agent.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

/**
 * V1 内部数据客户端：HTTP 调用 toB /admin/internal/** 只读接口拉取 FAQ 与商品数据
 *
 * <p>1. 携带 X-Internal-Token 服务间令牌鉴权
 * <p>2. updatedSince 为空拉全量，非空拉增量（ISO 时间格式）
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class InternalDataClient {

    private static final ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${aimall.tob-base-url}")
    private String tobBaseUrl;

    @Value("${aimall.internal-token}")
    private String internalToken;

    /**
     * 拉取 FAQ 列表，返回 JsonNode 列表（id/categoryId/title/content/status/updateTime）
     */
    public List<JsonNode> fetchFaqList(String updatedSince) {
        return fetchList("/admin/internal/faq/list", updatedSince);
    }

    /**
     * 拉取商品列表，返回 JsonNode 列表（spuId/name/categoryName/description/status/minPrice/maxPrice/totalStock/specSummary）
     */
    public List<JsonNode> fetchProductList(String updatedSince) {
        return fetchList("/admin/internal/product/list", updatedSince);
    }

    private List<JsonNode> fetchList(String path, String updatedSince) {
        String url = tobBaseUrl + path + (updatedSince != null ? "?updatedSince=" + updatedSince : "");
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Internal-Token", internalToken);
        try {
            String body = restTemplate.exchange(url, HttpMethod.GET, new HttpEntity<>(headers), String.class).getBody();
            JsonNode root = OBJECT_MAPPER.readTree(body);
            if (root.path("code").asInt() != 200) {
                throw new IllegalStateException("V1 内部接口返回失败: " + root.path("message").asText());
            }
            List<JsonNode> result = new ArrayList<>();
            root.path("data").forEach(result::add);
            return result;
        } catch (Exception e) {
            throw new IllegalStateException("拉取 V1 数据失败 " + path + ": " + e.getMessage(), e);
        }
    }
}
