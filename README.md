# Spring Native Kotlin Demo

This project leverages the `org.springframework.experimental.aot` plugin and GraalVM `native-image` to compile a Spring Boot Kotlin application to a native executable with a quick startup time.

## Build From Source

```shell
$ git clone https://github.com/Gorlah/spring-native-kotlin-demo.git
$ cd spring-native-kotlin-demo
$ docker build -t spring-native-kotlin-demo .
$ docker run --rm -it -p 8080:8080 spring-native-kotlin-demo
$ curl -X GET http://localhost:8080/greetings
Hello world!
```

## Comparison

### Optimized Image

With the `org.springframework.experimental.aot` plugin and GraalVM `native-image` optimizations, we can achieve a < 100ms container startup time. The resulting image is small too.
```shell
$ docker run --rm -it -p 8080:8080 spring-native-kotlin-demo
Started application in 0.056 seconds (JVM running for 0.057)
$ docker image ls
REPOSITORY                      TAG                           IMAGE ID       CREATED             SIZE
spring-native-kotlin-demo       latest                        fac2ec6a7bbc   22 seconds ago      91.2MB
```

### Standard Image

Running the built-in `bootBuildImage` task generates a container that starts up in > 1.5s, and the image size is much larger.
```shell
$ docker run --rm -it -p 8080:8080 spring-native-kotlin-demo:0.0.1-SNAPSHOT
Started SpringNativeDemoApplicationKt in 1.631 seconds (JVM running for 1.918)
$ docker image ls
REPOSITORY                   TAG                           IMAGE ID       CREATED         SIZE
spring-native-kotlin-demo    0.0.1-SNAPSHOT                15c62011481a   41 years ago    272MB
```
