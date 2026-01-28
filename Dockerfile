FROM amazonlinux:2023

ARG GRADLE_VERSION=8.10
ARG GRADLE_HOME=/opt/gradle

# 最低限ツールのみ
RUN dnf install -y \
    tar \
    gzip \
    unzip \
    curl \
 && dnf clean all

# Amazon Corretto 17 を公式tarで入れる（確実）
RUN curl -fsSL https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz \
    -o /tmp/corretto.tar.gz \
 && mkdir -p /opt/java \
 && tar -xzf /tmp/corretto.tar.gz -C /opt/java \
 && rm -f /tmp/corretto.tar.gz

# JAVA_HOME 設定
ENV JAVA_HOME=/opt/java/$(ls /opt/java)
ENV PATH=$JAVA_HOME/bin:$PATH

# Gradle
RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
 && unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt \
 && mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
 && rm -f gradle-${GRADLE_VERSION}-bin.zip

ENV GRADLE_HOME=${GRADLE_HOME}
ENV PATH=${GRADLE_HOME}/bin:${PATH}

WORKDIR /workspace
