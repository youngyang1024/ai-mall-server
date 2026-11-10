package com.aimall.agent.agent;

import com.aimall.agent.service.AgentConfigService;
import com.aimall.agent.service.RagService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.messages.AssistantMessage;
import org.springframework.ai.chat.messages.Message;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.ai.document.Document;
import org.springframework.ai.openai.OpenAiChatOptions;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Flux;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * 客服 Agent：基于 FAQ 知识库的 RAG 问答（P1 最小闭环）
 *
 * <p>提示词组装结构（RAG 三步的第 2、3 步）：
 * <p>1. SystemMessage = t_ai_agent_config 的系统提示词（B 端可编辑热生效）+ 检索到的 FAQ 参考资料
 * <p>2. 历史消息 = Redis 短期记忆的最近 N 轮（UserMessage/AssistantMessage 交替）
 * <p>3. 本轮 UserMessage = 用户问题；返回流式 Flux 由上层逐段推 SSE
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class CustomerServiceAgent {

    public static final String AGENT_CODE = "CUSTOMER_SERVICE";

    private final ChatModel chatModel;
    private final RagService ragService;
    private final AgentConfigService agentConfigService;

    /**
     * 流式回答：返回文字增量 Flux
     *
     * @param query   用户问题
     * @param history 短期记忆（role/content 列表，时间正序）
     */
    public Flux<String> stream(String query, List<Map<String, String>> history) {
        AgentConfigService.AgentConfig config = agentConfigService.get(AGENT_CODE);

        // RAG 第 1 步：检索 FAQ 知识库（query -> Embedding -> 相似度 topK）
        List<Document> references = ragService.searchFaq(query);

        // RAG 第 2 步：组装提示词（系统提示词 + 参考资料 + 历史 + 本轮问题）
        List<Message> messages = new ArrayList<>();
        messages.add(new SystemMessage(buildSystemPrompt(config.getSystemPrompt(), references)));
        for (Map<String, String> item : history) {
            if ("user".equals(item.get("role"))) {
                messages.add(new UserMessage(item.get("content")));
            } else {
                messages.add(new AssistantMessage(item.get("content")));
            }
        }
        messages.add(new UserMessage(query));

        // RAG 第 3 步：模型基于资料流式生成
        Prompt prompt = new Prompt(messages, OpenAiChatOptions.builder()
                .temperature(config.getTemperature().doubleValue())
                .build());
        return chatModel.stream(prompt)
                .mapNotNull(response -> response.getResult() == null ? null
                        : response.getResult().getOutput().getText());
    }

    private String buildSystemPrompt(String systemPrompt, List<Document> references) {
        StringBuilder sb = new StringBuilder(systemPrompt);
        sb.append("\n\n[参考资料]\n");
        if (references.isEmpty()) {
            sb.append("（本轮未检索到相关 FAQ，请按提示词中资料未覆盖的处理方式回答）");
        } else {
            for (int i = 0; i < references.size(); i++) {
                sb.append(i + 1).append(". ").append(references.get(i).getText()).append("\n");
            }
        }
        return sb.toString();
    }
}
