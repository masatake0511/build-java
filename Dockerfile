FROM amazonlinux:2023

ARG GRADLE_VERSION=8.10
ARG GRADLE_HOME=/opt/gradle

# 必要パッケージ
RUN dnf update -y \
 && dnf install -y \
    tar \
    gzip \
    unzip \
    curl \
    java-17-amazon-corretto-headless \
 && dnf clean all

# Gradle インストール
RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o /tmp/gradle.zip \
 && unzip /tmp/gradle.zip -d /opt \
 && mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
 && rm -f /tmp/gradle.zip

# PATH設定
ENV GRADLE_HOME=${GRADLE_HOME}
ENV PATH=${GRADLE_HOME}/bin:${PATH}

# 動作確認用（任意）
RUN gradle --version

WORKDIR /workspace
