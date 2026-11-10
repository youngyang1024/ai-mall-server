package com.aimall.agent.mapper;

import com.aimall.agent.entity.AiSession;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * t_ai_session 表数据访问，提供会话新增、按会话ID查询、身份维度列表、活跃时间更新与游客会话绑定用户等操作
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Mapper
public interface AiSessionMapper {

    int insert(AiSession session);

    AiSession selectBySessionId(@Param("sessionId") String sessionId);

    List<AiSession> selectByUserId(@Param("userId") Long userId);

    List<AiSession> selectByEid(@Param("eid") String eid);

    int updateTitle(@Param("sessionId") String sessionId, @Param("title") String title);

    int updateLastActiveTime(@Param("sessionId") String sessionId);

    int updateStatus(@Param("sessionId") String sessionId, @Param("status") String status);

    /** 游客登录后：将 eid 名下未绑定用户的会话迁移到 userId */
    int bindUserByEid(@Param("eid") String eid, @Param("userId") Long userId);
}
