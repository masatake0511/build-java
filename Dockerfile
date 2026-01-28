FROM amazoncorretto:17-al2023

ARG GRADLE_VERSION=8.10
ARG GRADLE_HOME=/opt/gradle

# Gradle インストール（dnf 不使用）
RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip \
 && unzip gradle.zip -d /opt \
 && mv /opt/gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
 && rm -f gradle.zip

ENV GRADLE_HOME=${GRADLE_HOME}
ENV PATH=${GRADLE_HOME}/bin:${PATH}

WORKDIR /workspace
