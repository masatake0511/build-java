FROM amazonlinux:2023

# 必須ツール一式（checkout / gradle / CI 用）
RUN dnf update -y && \
    dnf install -y \
      java-17-amazon-corretto-headless \
      tar \
      gzip \
      unzip \
      git \
      curl \
    && dnf clean all

# Gradle バージョン
ARG GRADLE_VERSION=8.10
ENV GRADLE_HOME=/opt/gradle
ENV PATH=${GRADLE_HOME}/bin:${PATH}

# Gradle インストール
RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip && \
    unzip gradle.zip -d /opt && \
    mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} && \
    rm -f gradle.zip

# GitHub Actions が使う作業ディレクトリ
WORKDIR /github/workspace

# 念のため確認用
RUN java -version && gradle -v
