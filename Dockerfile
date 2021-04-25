FROM gradle:6.8.3-jdk11 as gradle

FROM ghcr.io/graalvm/graalvm-ce:java11-21.1.0 as build
RUN gu install native-image && mkdir -p /tmp/app /tmp/jar /tmp/exec
COPY --from=gradle /opt/gradle /opt/gradle
ENV PATH="/opt/gradle/bin:${PATH}"

WORKDIR /tmp/app
COPY src /tmp/app/src
COPY build.gradle.kts settings.gradle.kts /tmp/app/
RUN gradle build

WORKDIR /tmp/jar
RUN jar xf /tmp/app/build/libs/spring-native-kotlin-demo-0.0.1-SNAPSHOT.jar

WORKDIR /tmp/exec
RUN mainClass=$(cat /tmp/app/build/bootJarMainClassName) && native-image \
    --static \
    --allow-incomplete-classpath \
    --report-unsupported-elements-at-runtime \
    --no-fallback \
    --no-server \
    --install-exit-handlers \
    -H:Name=app \
    -H:+InlineBeforeAnalysis \
    -cp /tmp/jar:/tmp/jar/BOOT-INF/classes:/tmp/jar/BOOT-INF/lib/* \
    $mainClass

FROM scratch
COPY --from=build /tmp/exec/app /
ENTRYPOINT ["/app"]
