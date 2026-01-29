FROM amazonlinux:2023

RUN dnf install -y \
      java-17-amazon-corretto \
      tar \
      gzip \
      unzip \
      git \
      curl \
    && dnf clean all

ARG GRADLE_VERSION=8.10
ENV GRADLE_HOME=/opt/gradle
ENV PATH=${GRADLE_HOME}/bin:${PATH}

RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
    unzip gradle.zip -d /opt && \
    mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} && \
    rm -f gradle.zip

WORKDIR /github/workspace
