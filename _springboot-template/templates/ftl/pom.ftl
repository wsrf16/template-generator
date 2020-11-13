<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>${groupId}</groupId>
    <artifactId>${artifactId}</artifactId>
    <version>${version}</version>
    <packaging>jar</packaging>

    <name>${moduleName}</name>
    <description>Web project for Spring Boot</description>

    <parent>
        <groupId>${parentGroupId}</groupId>
        <artifactId>${parentArtifactId}</artifactId>
        <version>${parentVersion}</version>
    </parent>

    <properties>
        <project.deploy.finalName>${finalName}</project.deploy.finalName>
        <project.deploy.basePath>/opt</project.deploy.basePath>
        <project.deploy.appPath><#noparse>${project.deploy.basePath}/${project.deploy.finalName}</#noparse></project.deploy.appPath>
        <project.deploy.directoryName.dependency>lib/</project.deploy.directoryName.dependency>
        <project.deploy.directoryName.profile>config/</project.deploy.directoryName.profile>
        <directory.profile>src/main/profiles</directory.profile>
        <directory.profile.active><#noparse>src/main/profiles/${profiles.active}</#noparse></directory.profile.active>
        <assembly-plugin.descriptor><#noparse>${project.build.scriptSourceDirectory}/assembly/assembly.xml</#noparse></assembly-plugin.descriptor>

        <docker.dockerfile.from>10.124.152.135/tianti/oracle-jdk8:v1.0</docker.dockerfile.from>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-aop</artifactId>
        </dependency>

        <!-- https://mvnrepository.com/artifact/io.springfox/springfox-swagger-ui -->
        <!--        <dependency>-->
        <!--            <groupId>io.springfox</groupId>-->
        <!--            <artifactId>springfox-swagger-ui</artifactId>-->
        <!--            <version><#noparse>${swagger.version}</#noparse></version>-->
        <!--        </dependency>-->

        <dependency>
            <groupId>com.unicom.software</groupId>
            <artifactId>service</artifactId>
            <version>1.0.0</version>
        </dependency>

        <dependency>
            <groupId>com.unicom.software</groupId>
            <artifactId>common</artifactId>
            <version>1.0.0</version>
        </dependency>

        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
        </dependency>

        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>provided</scope>
            <optional>true</optional>
        </dependency>

        <!-- https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-amqp -->
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-amqp</artifactId>
        </dependency>
    </dependencies>

    <profiles>
        <profile>
            <id>dev</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <profiles.active>dev</profiles.active>
                <args.app></args.app>
            </properties>
        </profile>
        <profile>
            <id>test</id>
            <properties>
                <profiles.active>test</profiles.active>
                <args.app></args.app>
            </properties>
        </profile>
        <profile>
            <id>uat</id>
            <properties>
                <profiles.active>uat</profiles.active>
            </properties>
        </profile>
        <profile>
            <id>pro</id>
            <properties>
                <profiles.active>pro</profiles.active>
            </properties>
        </profile>
    </profiles>
    <build>

        <finalName><#noparse>${project.deploy.finalName}</#noparse></finalName>
        <resources>
            <resource>
                <directory>src/main/resources</directory>
                <filtering>true</filtering>
                <includes>
                    <include>**/*</include>
                </includes>
                <excludes>
                    <exclude>application*.yml</exclude>
                    <exclude>application*.yaml</exclude>
                    <exclude>application*.properties</exclude>
                </excludes>
            </resource>

            <resource>
                <directory>src/main/resources</directory>
                <targetPath><#noparse>${project.deploy.directoryName.profile}</#noparse></targetPath>
                <filtering>true</filtering>
                <includes>
                    <include>application*.yml</include>
                    <include>application*.yaml</include>
                    <include>application*.properties</include>
                </includes>
            </resource>

            <resource>
                <directory><#noparse>${directory.profile}</#noparse></directory>
                <filtering>false</filtering>
                <excludes>
                    <exclude>**/*</exclude>
                </excludes>
            </resource>
            <resource>
                <directory><#noparse>${directory.profile.active}</#noparse></directory>
                <targetPath><#noparse>${project.deploy.directoryName.profile}</#noparse></targetPath>
                <filtering>true</filtering>
                <includes>
                    <include>**/*</include>
                </includes>
            </resource>
            <resource>
                <directory><#noparse>${project.build.scriptSourceDirectory}</#noparse></directory>
                <filtering>true</filtering>
                <excludes>
                    <exclude>**/*</exclude>
                </excludes>
            </resource>
            <resource>
                <directory><#noparse>${project.basedir}/docker</#noparse></directory>
                <targetPath><#noparse>${project.build.outputDirectory}/docker</#noparse></targetPath>
                <filtering>true</filtering>
                <includes>
                    <include>**/*</include>
                </includes>
            </resource>
        </resources>

        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.7.0</version>
                <configuration>
                    <source>1.8</source>
                    <target>1.8</target>
                    <skip>true</skip>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <layout>ZIP</layout>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <configuration>
                    <skipTests>true</skipTests>
                </configuration>
            </plugin>

            <plugin>
                <artifactId>maven-assembly-plugin</artifactId>
                <version>3.1.0</version>
                <executions>
                    <execution>
                        <id>make-zip</id>
                        <phase>package</phase>
                        <goals>
                            <goal>single</goal>
                        </goals>
                        <configuration>
                            <descriptors>
                                <descriptor><#noparse>${assembly-plugin.descriptor}</#noparse></descriptor>
                            </descriptors>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>

</project>
