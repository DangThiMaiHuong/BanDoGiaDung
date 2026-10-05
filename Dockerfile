FROM tomcat:9.0-jdk23-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY dist/BanDoGiaDung.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]