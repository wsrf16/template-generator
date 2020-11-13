package ${basePackage?lower_case}.${relativeNode};

import com.aio.portable.swiss.schedule.timer.AbstractTask;
import com.aio.portable.swiss.schedule.timer.Launcher;
import com.aio.portable.swiss.suite.log.LogHub;
import ${basePackage?lower_case}.config.root.ApplicationConfig;
import ${basePackage?lower_case}.config.root.children.LauncherConfig;
import ${basePackage?lower_case}.utils.AppLogHubFactory;
import com.ctrip.framework.apollo.Config;
import com.ctrip.framework.apollo.ConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Component;

@Component
public class AutoRunner implements CommandLineRunner {
    @Autowired
    ApplicationConfig config;

    @Autowired
    ThreadPoolTaskScheduler threadPoolTaskScheduler;

    LogHub log = AppLogHubFactory.staticBuild();

    @Override
    public void run(String... args) throws Exception {
        LauncherConfig launcherConfig = config.getLauncher();
        String cron = launcherConfig.getCron();
        Launcher launcher = new Launcher(new AbstractTask() {
            @Override
            public void run() {
                Config appConfig = ConfigService.getAppConfig();
                System.out.println("定时运行");
            }
        }, cron, threadPoolTaskScheduler, false);

        launcher.start();
    }


}
