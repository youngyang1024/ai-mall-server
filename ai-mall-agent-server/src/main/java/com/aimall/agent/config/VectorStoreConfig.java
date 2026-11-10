package com.aimall.agent.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.embedding.EmbeddingModel;
import org.springframework.ai.vectorstore.SimpleVectorStore;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.File;

/**
 * 向量库配置：SimpleVectorStore（本地文件持久化），业务代码一律面向 VectorStore 接口
 *
 * <p>1. 启动时若存在持久化文件则加载，知识库同步后由同步服务负责落盘
 * <p>2. 将来换 Milvus/Redis 等专业向量库仅替换本 Bean 与配置，业务代码零改动（D4 面向抽象决策）
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Configuration
public class VectorStoreConfig {

    /** 持久化文件名（目录由配置指定） */
    public static final String STORE_FILE = "vector-store.json";

    @Value("${aimall.vector-store-dir}")
    private String vectorStoreDir;

    @Bean
    public VectorStore vectorStore(EmbeddingModel embeddingModel) {
        SimpleVectorStore store = SimpleVectorStore.builder(embeddingModel).build();
        File file = new File(vectorStoreDir, STORE_FILE);
        if (file.exists()) {
            try {
                store.load(file);
                log.info("向量库已从本地文件加载: {}", file.getAbsolutePath());
            } catch (Exception e) {
                log.warn("向量库文件加载失败，将以空库启动（可通过全量重建恢复）: {}", e.getMessage());
            }
        } else {
            log.info("向量库文件不存在，以空库启动，等待知识库同步: {}", file.getAbsolutePath());
        }
        return store;
    }
}
