package com.aimall.tob.controller;

import com.aimall.common.result.Result;
import com.aimall.common.vo.PageResult;
import com.aimall.tob.dto.UserStatusDTO;
import com.aimall.tob.service.UserService;
import com.aimall.tob.vo.UserDetailVO;
import com.aimall.tob.vo.UserListVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * B端用户管理接口：列表（按用户名/手机号/状态分页查询）/详情/启用或禁用用户
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "用户管理")
@RestController
@RequestMapping("/admin/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @ApiOperation("用户列表")
    @GetMapping("/list")
    public Result<PageResult<UserListVO>> list(@RequestParam(required = false) String username,
                                               @RequestParam(required = false) String phone,
                                               @RequestParam(required = false) Integer status,
                                               @RequestParam(defaultValue = "1") int pageNum,
                                               @RequestParam(defaultValue = "10") int pageSize) {
        return Result.success(userService.list(username, phone, status, pageNum, pageSize));
    }

    @ApiOperation("用户详情")
    @GetMapping("/{id}/detail")
    public Result<UserDetailVO> detail(@PathVariable Long id) {
        return Result.success(userService.detail(id));
    }

    @ApiOperation("启用/禁用用户")
    @PutMapping("/{id}/status")
    public Result<Void> updateStatus(@PathVariable Long id, @Validated @RequestBody UserStatusDTO dto) {
        userService.updateStatus(id, dto.getStatus());
        return Result.success();
    }
}
