FROM sapmachine:jre-headless-ubuntu

ARG FUSEKI_VERSION=5.1.0
ARG WORKDIR=/opt
ARG FUSEKI_HOME=/opt/apache-jena-fuseki-${FUSEKI_VERSION}
ARG JENA_HOME=/opt/apache-jena-${FUSEKI_VERSION}
ARG DLCDN=https://dlcdn.apache.org/jena/binaries

WORKDIR $WORKDIR

RUN \
  apt update && apt install -y curl && \
  curl -s ${DLCDN}/apache-jena-fuseki-${FUSEKI_VERSION}.tar.gz | tar zx && \
  curl -s ${DLCDN}/apache-jena-${FUSEKI_VERSION}.tar.gz | tar zx

EXPOSE 3030

COPY bin .
COPY examples /examples

ENV \
  FUSEKI_HOME=${FUSEKI_HOME} \
  JENA_HOME=${JENA_HOME} \
  PATH="$WORKDIR:${FUSEKI_HOME}/bin:${JENA_HOME}/bin:$PATH" \
  JAVA_OPTIONS="-Xmx2G -Xms2G"  

CMD ["bash"]
