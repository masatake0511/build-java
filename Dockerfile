FROM amazonlinux:2023

# 必須ツールは curl / unzip だけに絞る
RUN microdnf install -y curl unzip && microdnf clean all

# Java は tar でインストール
ARG CORRETTO_VERSION=17.0.9.101-1
RUN curl -fsSL https://corretto.aws/downloads/resources/${CORRETTO_VERSION}/amazon-corretto-${CORRETTO_VERSION}-linux-x64.tar.gz \
    -o corretto.tar.gz && \
    mkdir -p /opt/java && \
    tar -xzf corretto.tar.gz -C /opt/java && \
    rm -f corretto.tar.gz

ENV JAVA_HOME=/opt/java/amazon-corretto-${CORRETTO_VERSION}-linux-x64
ENV PATH=${JAVA_HOME}/bin:${PATH}

# Gradle
ARG GRADLE_VERSION=8.10
ENV GRADLE_HOME=/opt/gradle
ENV PATH=${GRADLE_HOME}/bin:${PATH}

RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
    unzip gradle.zip -d /opt && \
    mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} && \
    rm -f gradle.zip

WORKDIR /github/workspace
