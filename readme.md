---
title: "Spring4shell_env"
date: 2023-04-03T14:09:50+08:00
draft: false
tags: 
author: 
categories:
typora-root-url: ..\..\static
---

## spring4shell环境搭建

- docker

- docker目录结构如下：

  ![image-20230403141117142](https://raw.githubusercontent.com/olist213/olistimg/master/picgo/202304031411216.png)

- src目录下是编译后的app

![image-20230403141158598](https://raw.githubusercontent.com/olist213/olistimg/master/picgo/202304031411645.png)



原项目如下：https://github.com/jbaines-r7/spring4shell_vulnapp

原项目无法构建成功，少了tomcat的环境

修改后dockerfile

```bash
FROM --platform=linux/amd64 openjdk:11

EXPOSE 8080

RUN apt update

ADD . / /springy
WORKDIR /springy

COPY apache-tomcat-8.5.77.zip /springy
RUN unzip apache-tomcat-8.5.77.zip
RUN chmod +x apache-tomcat-8.5.77/bin/*.sh

RUN cp src/vulnerable-1.0.0.0.war apache-tomcat-8.5.77/webapps/

CMD ["./apache-tomcat-8.5.77/bin/catalina.sh", "run"]
```

docker构建

```bash
docker build -t spring4shell .
docker run -itd -P spring4shell:latest

# 访问
http://192.168.101.154:32769/vulnerable-1.0.0.0/rapid7
```

---

## 漏洞利用

项目地址：https://github.com/reznok/Spring4Shell-POC

```bash
python3 exploit.py --url http://192.168.101.154:32769/vulnerable-1.0.0.0/rapid7
```

![image-20230403142011087](https://raw.githubusercontent.com/olist213/olistimg/master/picgo/202304031420131.png)

漏洞利用成功

![image-20230403142108638](https://raw.githubusercontent.com/olist213/olistimg/master/picgo/202304031421683.png)

