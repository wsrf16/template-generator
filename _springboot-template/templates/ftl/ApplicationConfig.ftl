package ${basePackage?lower_case}.${relativeNode};

import ${basePackage?lower_case}.config.root.children.BusinessConfig;
import ${basePackage?lower_case}.config.root.children.LauncherConfig;
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
