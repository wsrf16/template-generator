package com.unicom.software.origin.api.config;

import com.aio.portable.swiss.autoconfigure.properties.Swagger2Properties;
import com.aio.portable.swiss.hamlet.swagger.SwaggerStatus;
import com.unicom.software.origin.api.controller.DemoController;
import com.unicom.software.origin.api.utils.BizStatusEnum;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.ResponseMessage;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.List;


@EnableSwagger2
@Configuration
@ConditionalOnClass(ApiInfo.class)
public class Swagger2Config {
    private final static List<ResponseMessage> responseMessageList() {
        return SwaggerStatus.toResponseMessageList(BizStatusEnum.values());
    }

    @Bean
    @ConditionalOnClass(ApiInfo.class)
    @ConditionalOnProperty(prefix = "swagger.api-info", name = "title")
    @ConfigurationProperties(prefix = "swagger")
    public Swagger2Properties swagger2Properties() {
        return Swagger2Properties.build(DemoController.class.getPackage().getName(), responseMessageList());
    }

}

