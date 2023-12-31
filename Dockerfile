FROM amazoncorretto:21-alpine3.18

ARG FUSEKI_VERSION=4.10.0
ARG DLCDN=https://dlcdn.apache.org/jena/binaries

WORKDIR /opt 

RUN \
  apk --no-cache add curl && \
  curl -s ${DLCDN}/apache-jena-fuseki-${FUSEKI_VERSION}.tar.gz | tar zx && \
  mv apache-jena-fuseki-${FUSEKI_VERSION} fuseki && \
  curl -s ${DLCDN}/apache-jena-${FUSEKI_VERSION}.tar.gz | tar zx && \
  mv apache-jena-${FUSEKI_VERSION} jena

EXPOSE 3030

WORKDIR /opt
COPY entrypoint.sh .

ENV \
  PATH=$PATH:/opt/jena/bin:/opt/fuseki/bin \
  FUSEKI_HOME=/opt/fuseki \
  FUSEKI_DIR=/opt/fuseki \
  FUSEKI_JAR=fuseki-server.jar \
  JAVA_OPTIONS="-Xmx2G -Xms2G"  

ENTRYPOINT ["./entrypoint.sh" ]
CMD []
