package com.aimall.toc;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * C端商城服务启动类
 */
@SpringBootApplication(scanBasePackages = "com.aimall")
@MapperScan("com.aimall.toc.mapper")
@EnableScheduling
@Slf4j
public class ToCApplication {

    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        ConfigurableApplicationContext springContext = SpringApplication.run(ToCApplication.class, args);

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
