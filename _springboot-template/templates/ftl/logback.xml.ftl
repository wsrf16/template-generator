<?xml version="1.0" encoding="UTF-8"?>
<configuration scan="true" scanPeriod="60 seconds" debug="false">
    <contextName>unicom-log</contextName>
    <property name="LOG_HOME" value="log"/>
    <property name="LOG_FILENAME_PATTERN" value="<#noparse>${LOG_HOME}/%d{yyyy-MM-dd}.log</#noparse>"/>
    <property name="COLOUR_PATTERN"
              value="%d{yyyy-MM-dd HH:mm:ss.SSS} %yellow(%contextName[%thread]) %highlight(%-5level) %green(%logger{100}) %L - %msg %n"/>
    <property name="NORMAL_PATTERN"
              value="%date{yyyy-MM-dd HH:mm:ss} %contextName[%thread] %-5level %logger{100} %L - %msg%n"/>

    <appender name="STD_OUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <pattern><#noparse>${COLOUR_PATTERN}</#noparse></pattern>
            <charset>utf8</charset>
        </encoder>
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
            <level>INFO</level>
        </filter>
    </appender>

    <appender name="ROLE_FILE_LOG" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <Prudent>true</Prudent>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <FileNamePattern><#noparse>${LOG_FILENAME_PATTERN}</#noparse></FileNamePattern>
            <MaxHistory>30</MaxHistory>
        </rollingPolicy>
        <triggeringPolicy class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy">
            <MaxFileSize>200MB</MaxFileSize>
        </triggeringPolicy>
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <pattern><#noparse>${NORMAL_PATTERN}</#noparse></pattern>
            <charset>UTF-8</charset>
        </encoder>
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
            <level>DEBUG</level>
        </filter>
    </appender>

    <root level="INFO">
        <appender-ref ref="STD_OUT"/>
        <!--<appender-ref ref="ROLE_FILE_LOG"/>-->
    </root>

    <logger name="com.unicom.software.db.master.dao" level="debug" />
</configuration>