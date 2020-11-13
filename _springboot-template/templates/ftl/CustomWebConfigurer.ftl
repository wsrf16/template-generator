package ${basePackage?lower_case}.${relativeNode};

import com.aio.portable.swiss.hamlet.interceptor.HamletWebMvcConfigurer;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CustomWebConfigurer extends HamletWebMvcConfigurer {

}