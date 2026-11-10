package com.aimall.agent.config;

import com.aimall.agent.interceptor.ChatAuthInterceptor;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Web MVC 配置：认证拦截器注册与跨域
 *
 * <p>1. /agent/** 全部经过 ChatAuthInterceptor（登录/游客双身份解析），冒烟接口除外
 * <p>2. CORS 放开给 C 端前端本地开发（9092）
 *
 * @author
 * Created by Yang on 2026/07/26
 */
@Configuration
@RequiredArgsConstructor
public class WebMvcConfig implements WebMvcConfigurer {

    private final ChatAuthInterceptor chatAuthInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(chatAuthInterceptor)
                .addPathPatterns("/agent/**")
                .excludePathPatterns("/agent/smoke/**", "/agent/internal/**");
    }

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOriginPatterns("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}
