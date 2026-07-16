package com.aimall.tob.service.impl;

import com.aimall.common.constant.RedisKeyConstant;
import com.aimall.common.entity.User;
import com.aimall.common.exception.BusinessException;
import com.aimall.common.util.RedisUtil;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.mapper.UserMapper;
import com.aimall.tob.service.UserService;
import com.aimall.tob.vo.UserDetailVO;
import com.aimall.tob.vo.UserListVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * C端用户管理服务实现（B端后台）
 * <p>1. 列表/详情：基于 PageHelper 分页按用户名/手机号/状态查询用户，详情额外聚合订单数、累计支付金额、退款数、工单数等统计字段
 * <p>2. 启用/禁用：updateStatus 先校验用户存在再更新状态；禁用（status = 0）时按 RedisKeyConstant 拼出该用户 C 端登录 token 的 Redis key 并删除，令其登录态立即失效、强制下线
 * <p>3. 依赖 UserMapper 与 RedisUtil
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final RedisUtil redisUtil;

    public UserServiceImpl(UserMapper userMapper, RedisUtil redisUtil) {
        this.userMapper = userMapper;
        this.redisUtil = redisUtil;
    }

    @Override
    public PageResult<UserListVO> list(String username, String phone, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<User> users = userMapper.selectList(username, phone, status);
        PageInfo<User> pageInfo = new PageInfo<>(users);
        List<UserListVO> list = users.stream().map(this::toListVO).collect(Collectors.toList());
        return PageResult.of(list, pageInfo.getTotal(), pageNum, pageSize);
    }

    @Override
    public UserDetailVO detail(Long id) {
        User user = requireUser(id);
        UserDetailVO vo = new UserDetailVO();
        BeanUtils.copyProperties(user, vo);
        vo.setOrderCount(userMapper.countOrder(id));
        vo.setTotalPayAmount(userMapper.sumPayAmount(id));
        vo.setRefundCount(userMapper.countRefund(id));
        vo.setTicketCount(userMapper.countServiceTicket(id));
        return vo;
    }

    @Override
    public void updateStatus(Long id, Integer status) {
        requireUser(id);
        userMapper.updateStatus(id, status);
        // 禁用时删除该用户的 C 端登录 Token，使其立即下线
        if (status != null && status == 0) {
            String tokenKey = RedisKeyConstant.tokenKey(RedisKeyConstant.USER_TYPE_C, id);
            redisUtil.delete(tokenKey);
        }
    }

    private User requireUser(Long id) {
        User user = userMapper.selectById(id);
        if (user == null) {
            throw new BusinessException("用户不存在");
        }
        return user;
    }

    private UserListVO toListVO(User user) {
        UserListVO vo = new UserListVO();
        BeanUtils.copyProperties(user, vo);
        return vo;
    }
}
