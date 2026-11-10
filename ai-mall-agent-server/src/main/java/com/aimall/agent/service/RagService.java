package com.aimall.agent.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.SearchRequest;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.ai.vectorstore.filter.FilterExpressionBuilder;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * RAG 检索服务：按语义相似度检索知识库，元数据过滤类型与状态
 *
 * <p>1. 检索链路：query 文本 -> Embedding（框架内部调用）-> 余弦相似度排序 -> topK + 阈值 + 元数据过滤
 * <p>2. status=1 过滤：下架商品/禁用 FAQ 不出现在召回结果（同步侧不即时删向量，检索侧兜底）
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RagService {

    private static final int DEFAULT_TOP_K = 4;
    private static final double DEFAULT_THRESHOLD = 0.5;

    private final VectorStore vectorStore;

    /**
     * 检索 FAQ 知识库
     */
    public List<Document> searchFaq(String query) {
        return search(query, KnowledgeBaseService.KB_TYPE_FAQ);
    }

    /**
     * 检索商品知识库
     */
    public List<Document> searchProduct(String query) {
        return search(query, KnowledgeBaseService.KB_TYPE_PRODUCT);
    }

    private List<Document> search(String query, String kbType) {
        FilterExpressionBuilder builder = new FilterExpressionBuilder();
        List<Document> documents = vectorStore.similaritySearch(SearchRequest.builder()
                .query(query)
                .topK(DEFAULT_TOP_K)
                .similarityThreshold(DEFAULT_THRESHOLD)
                .filterExpression(builder.and(
                        builder.eq("type", kbType),
                        builder.eq("status", 1)).build())
                .build());
        log.debug("RAG 检索 kbType={} query={} hits={}", kbType, query, documents == null ? 0 : documents.size());
        return documents == null ? List.of() : documents;
    }
}
