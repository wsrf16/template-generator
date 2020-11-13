package ${basePackage?lower_case}.${relativeNode};

import lombok.Data;

@Data
public class LauncherConfig {
    private String cron;

}
