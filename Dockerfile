FROM amazoncorretto:17-al2023

ARG GRADLE_VERSION=8.10
ARG GRADLE_HOME=/opt/gradle

WORKDIR /tmp

# Gradle を jar で展開（unzip 不要）
RUN curl -fsSL https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle.zip \
 && jar -xf gradle.zip \
 && mv gradle-${GRADLE_VERSION} ${GRADLE_HOME} \
 && rm -f gradle.zip

ENV GRADLE_HOME=${GRADLE_HOME}
ENV PATH=${GRADLE_HOME}/bin:${PATH}

WORKDIR /workspace
