package com.aimall.toc.config;

import com.aimall.toc.interceptor.UserAuthInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * C端 Web MVC 配置，集中管理认证拦截、参数转换与跨域策略
 *
 * <p>1. 注册 UserAuthInterceptor 拦截 /api/** 路径，并放行登录/注册、商品/分类/轮播图浏览、评价列表、Swagger 文档等无需登录的接口
 * <p>2. 注册 String 到 LocalDateTime 的参数转换器（yyyy-MM-dd HH:mm:ss 格式），并声明 BCryptPasswordEncoder Bean 供认证服务使用
 * <p>3. 配置全局 CORS 跨域：允许任意来源模式与常用 HTTP 方法，携带凭证，预检结果缓存 3600 秒
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    private final UserAuthInterceptor userAuthInterceptor;

    public WebMvcConfig(UserAuthInterceptor userAuthInterceptor) {
        this.userAuthInterceptor = userAuthInterceptor;
    }

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    public void addFormatters(FormatterRegistry registry) {
        registry.addConverter(new Converter<String, LocalDateTime>() {
            @Override
            public LocalDateTime convert(String source) {
                if (source.isEmpty()) {
                    return null;
                }
                return LocalDateTime.parse(source, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
        });
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(userAuthInterceptor)
                .addPathPatterns("/api/**")
                .excludePathPatterns(
                        "/api/auth/login",
                        "/api/auth/register",
                        "/api/health",
                        "/api/category/**",
                        "/api/product/**",
                        "/api/banner/**",
                        "/api/service-ticket/options",
                        "/api/hot-search/**",
                        "/api/review/list",
                        "/api/review/summary",
                        "/doc.html",
                        "/swagger-resources/**",
                        "/v2/api-docs/**",
                        "/webjars/**"
                );
    }

    @Override
    public void addCorsMappings(org.springframework.web.servlet.config.annotation.CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOriginPatterns("*")
                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                .allowedHeaders("*")
                .allowCredentials(true)
                .maxAge(3600);
    }
}
