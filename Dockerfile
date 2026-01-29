# Ubuntu 22.04 をベースにする
FROM ubuntu:22.04

# 必須ツールのインストール
RUN apt-get update && apt-get install -y \
      openjdk-17-jdk \
      curl \
      unzip \
      git \
      tar \
      gzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Gradle
ARG GRADLE_VERSION=8.10
ENV GRADLE_HOME=/opt/gradle
ENV PATH=${GRADLE_HOME}/bin:${PATH}

RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
    unzip gradle.zip -d /opt && \
    mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} && \
    rm -f gradle.zip

# 作業ディレクトリ
WORKDIR /github/workspace

# 確認用
RUN java -version && gradle -v
