package com.unicom.software.origin.api.timer;

import com.aio.portable.swiss.schedule.timer.AbstractTask;
import com.aio.portable.swiss.schedule.timer.Launcher;
import com.aio.portable.swiss.suite.log.LogHub;
import com.unicom.software.origin.api.config.root.ApplicationConfig;
import com.unicom.software.origin.api.config.root.children.LauncherConfig;
import com.unicom.software.origin.api.freemarker.FreemarkerGenerator;
import com.unicom.software.origin.api.utils.AppLogHubFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.stereotype.Component;

@Component
public class AutoRunner implements CommandLineRunner {

//    @Autowired
//    BookMasterService bookMasterService;
//
//    @Autowired
//    BookSlaveService bookSlaveService;

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
                System.out.println("定时运行");
            }
        }, cron, threadPoolTaskScheduler, false);

//        launcher.start();

        String projectDirectory = "_springboot-template";
        FreemarkerGenerator freemarkerGenerator = new FreemarkerGenerator(projectDirectory);
        freemarkerGenerator.generate();

        System.out.println();
        System.exit(0);
    }


}
