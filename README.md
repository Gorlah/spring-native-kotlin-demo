# Spring Native Kotlin Demo

This project leverages the `org.springframework.experimental.aot` plugin and GraalVM `native-image` to compile a Spring Boot Kotlin application to a native executable with a quick startup time.

## Example
The container startup time is < 100ms.
```shell
$ docker run --rm -it -p 8080:8080 spring-native-kotlin-demo
...
Started application in 0.056 seconds (JVM running for 0.057)
```

The resulting image size is small too!
```shell
$ docker image ls
REPOSITORY                      TAG                           IMAGE ID       CREATED          SIZE
spring-native-kotlin-demo       latest                        3504775036b7   50 seconds ago   89MB
```

## Build From Source

```shell
$ git clone https://github.com/Gorlah/spring-native-kotlin-demo.git
$ cd spring-native-kotlin-demo
$ docker build -t spring-native-kotlin-demo .
$ docker run --rm -it -p 8080:8080 spring-native-kotlin-demo
$ curl -X GET http://localhost:8080/greetings
Hello world!
```