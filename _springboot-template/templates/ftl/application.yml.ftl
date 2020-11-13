server:
  port: 8084

spring:
  application:
    name: @project.deploy.finalName@

  profiles:
    active:
      @profiles.active@

  rest:
    agent:
      enable: false
      host: 127.0.0.1
      port: 8888

  jackson:
    date-format: yyyy-MM-dd HH:mm:ss

ribbon:
  ReadTimeout: 60000
  ConnectTimeout: 60000

pagehelper:
  helper-dialect: mysql
  offset-as-page-num: true
  row-bounds-with-count: true
  pageSizeZero: true
  reasonable: true
  support-methods-arguments: true

swagger:
  enable: true
  version: 1.0
  api-info:
    title: 接口在线文档
    description: 中国联通软件研究院
    terms-of-service-url: www.unicom.cn
    license: Apache 2.0
    licenseUrl: http://www.apache.org/licenses/LICENSE-2.0.html
    version: 1.1
    contact:
      name: 联通
      url: www.unicom.com
      email: unicom@unicom.com

config:
  launcher:
    cron: "*/10 * * * * ?"

app:
  id: ${appId}
apollo:
  bootstrap:
    enabled: true
    eagerLoad:
      enabled: true

---
spring:
  profiles: dev

apollo:
  meta: http://10.124.192.118:8080


---
spring:
  profiles: uat

apollo:
  meta: http://10.124.192.118:8082

---
spring:
  profiles: pro

apollo:
  meta: http://10.124.192.118:8081
