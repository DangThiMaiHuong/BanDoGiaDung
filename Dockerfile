FROM eclipse-temurin:23-jdk

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

RUN apt-get update \
    && apt-get install -y curl \
    && curl -fSL https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.46/bin/apache-tomcat-10.1.46.tar.gz -o /tmp/tomcat.tar.gz \
    && mkdir -p $CATALINA_HOME \
    && tar -xzf /tmp/tomcat.tar.gz -C $CATALINA_HOME --strip-components=1 \
    && rm /tmp/tomcat.tar.gz \
    && rm -rf $CATALINA_HOME/webapps/* \
    && rm -rf /var/lib/apt/lists/*

COPY dist/BanDoGiaDung.war $CATALINA_HOME/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
