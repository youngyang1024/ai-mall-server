package com.aimall.agent.mapper;

import com.aimall.agent.entity.AiMessage;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_ai_message 表数据访问，提供消息新增、按会话分页查询、生成状态与内容更新及游客消息绑定用户等操作
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Mapper
public interface AiMessageMapper {

    int insert(AiMessage message);

    AiMessage selectByMessageId(@Param("messageId") String messageId);

    /** 按会话查询消息（时间正序），offset/limit 分页 */
    List<AiMessage> selectBySessionId(@Param("sessionId") String sessionId,
                                      @Param("offset") int offset,
                                      @Param("limit") int limit);

    /** 查询会话最近 N 条消息（时间倒序），用于短期记忆兜底重建 */
    List<AiMessage> selectRecentBySessionId(@Param("sessionId") String sessionId, @Param("limit") int limit);

    /** 生成结束时回填内容/卡片/token/状态/完成时间 */
    int updateCompletion(@Param("messageId") String messageId,
                         @Param("status") String status,
                         @Param("content") String content,
                         @Param("cardsJson") String cardsJson,
                         @Param("tokenUsage") Integer tokenUsage);

    /** 游客登录后：将 eid 名下未绑定用户的消息迁移到 userId */
    int bindUserByEid(@Param("eid") String eid, @Param("userId") Long userId);
}
