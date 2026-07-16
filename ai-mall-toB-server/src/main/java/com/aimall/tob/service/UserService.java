package com.aimall.tob.service;

import com.aimall.common.vo.PageResult;
import com.aimall.tob.vo.UserDetailVO;
import com.aimall.tob.vo.UserListVO;

/**
 * B端用户管理业务接口：定义用户分页查询（支持按用户名、手机号、状态筛选）、详情查询、账号状态变更能力
 *
 * @author
 * Created by Yang on 2026/07/16
 */
public interface UserService {

    PageResult<UserListVO> list(String username, String phone, Integer status, int pageNum, int pageSize);

    UserDetailVO detail(Long id);

    void updateStatus(Long id, Integer status);
}
