FROM amazoncorretto:21-alpine3.18

ARG FUSEKI_VERSION=4.10.0
ARG DLCDN=https://dlcdn.apache.org/jena/binaries

WORKDIR /opt 

RUN \
  apk --no-cache add curl && \
  curl -s ${DLCDN}/apache-jena-fuseki-${FUSEKI_VERSION}.tar.gz | tar zx

EXPOSE 3030

WORKDIR /opt
COPY entrypoint.sh .

ENV \
  FUSEKI_HOME=/opt/apache-jena-fuseki-${FUSEKI_VERSION} \
  FUSEKI_DIR=/opt/apache-jena-fuseki-${FUSEKI_VERSION} \
  FUSEKI_JAR=fuseki-server.jar \
  JAVA_OPTIONS="-Xmx2G -Xms2G"  

ENTRYPOINT ["./entrypoint.sh" ]
CMD []
