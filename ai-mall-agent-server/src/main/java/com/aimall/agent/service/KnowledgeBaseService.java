package com.aimall.agent.service;

import com.aimall.agent.config.VectorStoreConfig;
import com.fasterxml.jackson.databind.JsonNode;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.SimpleVectorStore;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.ai.vectorstore.filter.FilterExpressionBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.io.File;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 知识库同步服务：FAQ/商品数据 -> 文档构造 -> Embedding -> 向量库写入
 *
 * <p>1. 文档构造原则：每块自包含（含标题/名称等主体信息），保证被单独召回后模型能读懂（防断章幻觉）
 * <p>2. 文档 ID 稳定（faq-{id} / product-{spuId}），upsert 语义：先删旧向量再写新向量
 * <p>3. 元数据带 type 与 status，检索时按 type 分库过滤、按 status 过滤下架/禁用内容
 * <p>4. 定时增量（30 分钟，按 update_time）+ 手动全量重建两条路；每次同步写 t_ai_kb_sync_log
 * <p>5. 同步后将 SimpleVectorStore 落盘持久化，重启不丢
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class KnowledgeBaseService {

    /** 知识库类型（文档元数据 type 与同步日志 kb_type） */
    public static final String KB_TYPE_FAQ = "FAQ";
    public static final String KB_TYPE_PRODUCT = "PRODUCT";

    private final VectorStore vectorStore;
    private final InternalDataClient internalDataClient;
    private final JdbcTemplate jdbcTemplate;

    @Value("${aimall.vector-store-dir}")
    private String vectorStoreDir;

    /** 同步互斥锁：定时增量与手动全量不并发执行 */
    private final ReentrantLock syncLock = new ReentrantLock();

    /** 上次增量同步时间（服务启动后首次增量等价于全量） */
    private volatile LocalDateTime lastSyncTime;

    /**
     * 定时增量同步（每 30 分钟）；任一知识库失败则不推进水位，下轮重拉失败窗口的数据
     */
    @Scheduled(fixedDelay = 30 * 60 * 1000, initialDelay = 60 * 1000)
    public void incrementSync() {
        String since = lastSyncTime == null ? null : lastSyncTime.toString();
        LocalDateTime startAt = LocalDateTime.now();
        try {
            syncFaq(since, "INCREMENT");
            syncProduct(since, "INCREMENT");
            lastSyncTime = startAt;
        } catch (SyncFailedException e) {
            log.warn("增量同步存在失败，本轮不推进同步水位 lastSyncTime={}", lastSyncTime);
        }
    }

    /**
     * 手动全量重建（B 端触发；换 Embedding 模型/换向量库后也走此路）
     * <p>先清空对应知识库再重建：僵尸向量（已物理删除的 FAQ/商品）只有这条路能清理
     */
    public void fullRebuild() {
        LocalDateTime startAt = LocalDateTime.now();
        try {
            clearByType(KB_TYPE_FAQ);
            syncFaq(null, "FULL");
            clearByType(KB_TYPE_PRODUCT);
            syncProduct(null, "FULL");
            lastSyncTime = startAt;
        } catch (SyncFailedException e) {
            log.warn("全量重建存在失败，详见 t_ai_kb_sync_log");
        }
    }

    /**
     * 按知识库类型清空向量（源数据在 MySQL，可安全重建）
     */
    private void clearByType(String kbType) {
        try {
            FilterExpressionBuilder builder = new FilterExpressionBuilder();
            vectorStore.delete(builder.eq("type", kbType).build());
        } catch (Exception e) {
            log.warn("清空知识库 {} 失败（空库时属正常）: {}", kbType, e.getMessage());
        }
    }

    private void syncFaq(String updatedSince, String syncType) {
        runSync(KB_TYPE_FAQ, syncType, () -> {
            List<JsonNode> faqs = internalDataClient.fetchFaqList(updatedSince);
            List<Document> documents = new ArrayList<>();
            List<String> staleIds = new ArrayList<>();
            for (JsonNode faq : faqs) {
                String docId = "faq-" + faq.path("id").asLong();
                staleIds.add(docId);
                // 文档构造：标题+内容拼为自包含文本块
                String text = "【" + faq.path("title").asText() + "】\n" + faq.path("content").asText();
                documents.add(Document.builder()
                        .id(docId)
                        .text(text)
                        .metadata(Map.of(
                                "type", KB_TYPE_FAQ,
                                "faqId", faq.path("id").asLong(),
                                "title", faq.path("title").asText(),
                                "status", faq.path("status").asInt()))
                        .build());
            }
            upsert(staleIds, documents);
            return documents.size();
        });
    }

    private void syncProduct(String updatedSince, String syncType) {
        runSync(KB_TYPE_PRODUCT, syncType, () -> {
            List<JsonNode> products = internalDataClient.fetchProductList(updatedSince);
            List<Document> documents = new ArrayList<>();
            List<String> staleIds = new ArrayList<>();
            for (JsonNode p : products) {
                String docId = "product-" + p.path("spuId").asLong();
                staleIds.add(docId);
                // 文档构造：名称+分类+描述+规格+价格区间，一个 SPU 一块，自包含
                StringBuilder text = new StringBuilder();
                text.append("商品：").append(p.path("name").asText()).append("\n");
                text.append("分类：").append(p.path("categoryName").asText("")).append("\n");
                if (!p.path("description").isNull() && !p.path("description").asText().isEmpty()) {
                    text.append("描述：").append(p.path("description").asText()).append("\n");
                }
                text.append("规格：").append(p.path("specSummary").asText("")).append("\n");
                text.append("价格：").append(p.path("minPrice").asText())
                        .append(" ~ ").append(p.path("maxPrice").asText());
                documents.add(Document.builder()
                        .id(docId)
                        .text(text.toString())
                        .metadata(Map.of(
                                "type", KB_TYPE_PRODUCT,
                                "spuId", p.path("spuId").asLong(),
                                "name", p.path("name").asText(),
                                "status", p.path("status").asInt()))
                        .build());
            }
            upsert(staleIds, documents);
            return documents.size();
        });
    }

    /**
     * upsert：先删同 ID 旧向量，再写新向量（SimpleVectorStore 无原生 upsert），随后落盘
     */
    private void upsert(List<String> ids, List<Document> documents) {
        if (documents.isEmpty()) {
            return;
        }
        try {
            vectorStore.delete(ids);
        } catch (Exception e) {
            // 首次写入无旧向量可删，忽略
        }
        vectorStore.add(documents);
        persist();
    }

    private void persist() {
        if (vectorStore instanceof SimpleVectorStore simpleStore) {
            File dir = new File(vectorStoreDir);
            if (!dir.exists() && !dir.mkdirs()) {
                log.warn("向量库持久化目录创建失败: {}", dir.getAbsolutePath());
                return;
            }
            simpleStore.save(new File(dir, VectorStoreConfig.STORE_FILE));
        }
    }

    /**
     * 同步执行模板：写 RUNNING 日志 -> 执行 -> 回写 SUCCESS/FAILED
     */
    private void runSync(String kbType, String syncType, SyncAction action) {
        if (!syncLock.tryLock()) {
            log.info("知识库同步进行中，跳过本次 {} {}", kbType, syncType);
            return;
        }
        long start = System.currentTimeMillis();
        try {
            // GeneratedKeyHolder 保证在同一连接内拿回自增主键（两次 jdbcTemplate 调用不保证同连接，不能用 LAST_INSERT_ID()）
            GeneratedKeyHolder keyHolder = new GeneratedKeyHolder();
            jdbcTemplate.update(con -> {
                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO t_ai_kb_sync_log (kb_type, sync_type, status) VALUES (?, ?, 'RUNNING')",
                        Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, kbType);
                ps.setString(2, syncType);
                return ps;
            }, keyHolder);
            Number key = keyHolder.getKey();
            long logId = key == null ? 0 : key.longValue();
            try {
                int count = action.run();
                jdbcTemplate.update("UPDATE t_ai_kb_sync_log SET status = 'SUCCESS', doc_count = ?, cost_ms = ? WHERE id = ?",
                        count, System.currentTimeMillis() - start, logId);
                log.info("知识库同步完成 kbType={} syncType={} docs={} costMs={}",
                        kbType, syncType, count, System.currentTimeMillis() - start);
            } catch (Exception e) {
                jdbcTemplate.update("UPDATE t_ai_kb_sync_log SET status = 'FAILED', error_msg = ?, cost_ms = ? WHERE id = ?",
                        truncate(e.getMessage()), System.currentTimeMillis() - start, logId);
                log.error("知识库同步失败 kbType={} syncType={}", kbType, syncType, e);
                throw new SyncFailedException(e);
            }
        } finally {
            syncLock.unlock();
        }
    }

    private String truncate(String msg) {
        if (msg == null) {
            return null;
        }
        return msg.length() > 900 ? msg.substring(0, 900) : msg;
    }

    @FunctionalInterface
    private interface SyncAction {
        int run() throws Exception;
    }

    /**
     * 同步失败信号：向上传递给调用方决定是否推进水位（日志已在 runSync 落库）
     */
    private static class SyncFailedException extends RuntimeException {
        SyncFailedException(Throwable cause) {
            super(cause);
        }
    }
}
