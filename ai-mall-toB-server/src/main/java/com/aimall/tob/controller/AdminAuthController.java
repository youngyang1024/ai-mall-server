package com.aimall.tob.controller;

import com.aimall.common.context.UserContext;
import com.aimall.common.result.Result;
import com.aimall.tob.dto.LoginDTO;
import com.aimall.tob.service.AdminAuthService;
import com.aimall.tob.vo.LoginVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 管理员认证接口：B端管理员登录/登出
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Api(tags = "管理员认证")
@RestController
@RequestMapping("/admin/auth")
public class AdminAuthController {

    private final AdminAuthService adminAuthService;

    public AdminAuthController(AdminAuthService adminAuthService) {
        this.adminAuthService = adminAuthService;
    }

    @ApiOperation("管理员登录")
    @PostMapping("/login")
    public Result<LoginVO> login(@Validated @RequestBody LoginDTO loginDTO) {
        return Result.success(adminAuthService.login(loginDTO));
    }

    @ApiOperation("管理员登出")
    @PostMapping("/logout")
    public Result<Void> logout() {
        adminAuthService.logout(UserContext.getUserId());
        return Result.success();
    }
}
