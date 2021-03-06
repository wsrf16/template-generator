package ${basePackage?lower_case}.${relativeNode};

import com.aio.portable.swiss.suite.storage.rds.jpa.config.UserIDAuditorAware;
import org.springframework.boot.autoconfigure.condition.ConditionalOnBean;
import org.springframework.boot.autoconfigure.condition.ConditionalOnClass;
import org.springframework.boot.autoconfigure.orm.jpa.JpaProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConditionalOnClass(JpaProperties.class)
@ConditionalOnBean(JpaProperties.class)
public class UserIDAuditorBean extends UserIDAuditorAware<Long> {

}
