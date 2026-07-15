package com.aimall.toc.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.toc.dto.PasswordUpdateDTO;
import com.aimall.toc.dto.UserUpdateDTO;
import com.aimall.toc.service.UserService;
import com.aimall.toc.vo.UserInfoVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@Api(tags = "用户中心")
@RestController
@RequestMapping("/api/user")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @ApiOperation("获取当前用户信息")
    @GetMapping("/info")
    public Result<UserInfoVO> info() {
        return Result.success(userService.getInfo(UserContext.getUserId()));
    }

    @ApiOperation("修改个人资料")
    @PutMapping("/info")
    public Result<Void> updateInfo(@RequestBody UserUpdateDTO dto) {
        userService.updateInfo(UserContext.getUserId(), dto);
        return Result.success();
    }

    @ApiOperation("修改密码")
    @PutMapping("/password")
    public Result<Void> updatePassword(@Validated @RequestBody PasswordUpdateDTO dto) {
        userService.updatePassword(UserContext.getUserId(), dto);
        return Result.success();
    }
}
