package com.unicom.software.origin.api.freemarker;

import com.aio.portable.swiss.sugar.RegexSugar;
import org.springframework.util.StringUtils;

import java.text.MessageFormat;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class SpecificHolder {
    private final static String PLACE_HOLDER = "\\$\\'{'{0}\\'}'";

    public static void formatSpecific(Map<String, Object> map) {
        map.entrySet().stream().forEach(c -> {
            String key = c.getKey();
            Object value = getValueOfMap(map, key);
            map.put(key, value);
        });
    }

    private final static String placeHolder(String parameter) {
        return MessageFormat.format(PLACE_HOLDER, parameter);
    }

    private final static Object getValueOfMap(Map<String, Object> map, String key) {
        Object object = map.get(key);
        if (!(object instanceof String))
            return object;
        String value = (String) map.get(key);
        if (!StringUtils.hasText(value))
            return value;

        while (value.matches(".*?" + placeHolder(".+?") + ".*?")) {
            List<String> subKeys = RegexSugar.findMore(placeHolder("(.+?)"), value).stream().flatMap(_c -> _c.stream()).collect(Collectors.toList());

            for (String subKey : subKeys) {
                String subValue = (String) getValueOfMap(map, subKey);
                value = RegexSugar.replaceAll(value, placeHolder(subKey), subValue);
            }
        }
        return value;
    }



}
