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
