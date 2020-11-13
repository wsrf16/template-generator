package ${basePackage?lower_case}.${relativeNode};

import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
@Api(value = "${className?cap_first}",tags={"${name?uncap_first}"})
@RequestMapping("/${name?uncap_first}")
public class ${className?cap_first} {
<#--    @Autowired-->
<#--    private ${name?cap_first}Service ${name?uncap_first}Service;-->

    public static final List<String> UNIQUE_FIELDS = new ArrayList<>();

    static{
        UNIQUE_FIELDS.addAll(Arrays.asList(new String[]{}));
    }
}
