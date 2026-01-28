FROM amazonlinux:2023

ARG GRADLE_VERSION=8.10
ARG GRADLE_HOME=/opt/gradle
ARG JAVA_HOME=/opt/java/amazon-corretto-17

RUN dnf install -y \
    tar \
    gzip \
    unzip \
    curl \
 && dnf clean all

# Corretto 17
RUN curl -fsSL https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz \
 | tar -xz -C /opt/java

ENV JAVA_HOME=${JAVA_HOME}
ENV PATH=${JAVA_HOME}/bin:${PATH}

# Gradle
RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip \
 && unzip gradle.zip -d /opt \
 && mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
 && rm -f gradle.zip

ENV GRADLE_HOME=${GRADLE_HOME}
ENV PATH=${GRADLE_HOME}/bin:${PATH}

WORKDIR /workspace
