package com.aimall.tob;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

/**
 * B端管理服务启动类：启动 Spring Boot 应用（扫描 com.aimall 包并注册 MyBatis Mapper），记录启动耗时，并注册 shutdown 钩子在应用退出时关闭 Spring 容器
 *
 * @author
 * Created by Yang on 2026/07/16
 */
@SpringBootApplication(scanBasePackages = "com.aimall")
@MapperScan("com.aimall.tob.mapper")
@Slf4j
public class ToBApplication {

    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        ConfigurableApplicationContext springContext = SpringApplication.run(ToBApplication.class, args);

        log.info("application start success...... {}ms",System.currentTimeMillis()-startTime);

        Runtime.getRuntime().addShutdownHook(new Thread() {
            public void run() {
                log.info("application shutdown {} ",System.currentTimeMillis());
                if (springContext != null) {
                    springContext.stop();
                    springContext.close();
                }
            }
        });
    }
}
