FROM amazonlinux:2023

# 最小限のツール
RUN dnf install -y curl unzip tar gzip git && dnf clean all

# Java (Amazon Corretto 17) を公式 tar でインストール
RUN mkdir -p /opt/java && \
    curl -fsSL https://corretto.aws/downloads/latest/amazon-corretto-17-x64-linux-jdk.tar.gz -o corretto.tar.gz && \
    tar -xzf corretto.tar.gz -C /opt/java && \
    rm -f corretto.tar.gz

# JAVA_HOME 環境変数
ENV JAVA_HOME=/opt/java/amazon-corretto-17
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

# 確認
RUN java -version && gradle -v
