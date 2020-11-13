package com.unicom.software.origin.api.config.root;

import com.unicom.software.origin.api.config.root.children.BusinessConfig;
import com.unicom.software.origin.api.config.root.children.LauncherConfig;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
@ConfigurationProperties(prefix = "config")
public class ApplicationConfig {
    private LauncherConfig launcher;
    private BusinessConfig business;
}
