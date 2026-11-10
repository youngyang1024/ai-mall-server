package com.aimall.agent;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * AI 导购智能体服务启动类
 *
 * <p>1. 独立于 V1 主工程（JDK 21 + Spring Boot 4 + Spring AI 2.0），与 V1 仅通过 HTTP API 通信
 * <p>2. 承载 Coordinator 意图路由与导购/客服/售后三个子 Agent 的运行时
 * <p>3. EnableScheduling 用于知识库定时增量同步任务
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@EnableScheduling
@SpringBootApplication
public class AgentApplication {

    public static void main(String[] args) {
        SpringApplication.run(AgentApplication.class, args);
    }
}
