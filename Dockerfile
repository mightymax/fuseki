FROM eclipse-temurin:21-jre-jammy

ARG FUSEKI_VERSION=6.0.0
ARG WORKDIR=/opt
ARG FUSEKI_HOME=/opt/apache-jena-fuseki-${FUSEKI_VERSION}
ARG JENA_HOME=/opt/apache-jena-${FUSEKI_VERSION}
ARG DLCDN=https://dlcdn.apache.org/jena/binaries

WORKDIR $WORKDIR

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN set -eux; \
  apt-get update && \
  apt-get install -y --no-install-recommends ca-certificates curl tar && \
  rm -rf /var/lib/apt/lists/* && \
  curl -fsSL "${DLCDN}/apache-jena-fuseki-${FUSEKI_VERSION}.tar.gz" | tar -xz -C "$WORKDIR" && \
  curl -fsSL "${DLCDN}/apache-jena-${FUSEKI_VERSION}.tar.gz" | tar -xz -C "$WORKDIR"

EXPOSE 3030

COPY bin/ .
COPY examples /examples

ENV \
  FUSEKI_HOME=${FUSEKI_HOME} \
  JENA_HOME=${JENA_HOME} \
  PATH="$WORKDIR:${FUSEKI_HOME}/bin:${JENA_HOME}/bin:$PATH" \
  JAVA_OPTIONS="-Xmx2G -Xms2G"

CMD ["bash"]
