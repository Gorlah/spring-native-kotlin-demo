package com.gorlah.demo

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean
import org.springframework.web.reactive.function.server.queryParamOrNull
import org.springframework.web.reactive.function.server.router

@SpringBootApplication
class SpringNativeDemoApplication {

    @Bean
    fun route() = router {
        GET("/greetings") { ok().bodyValue(getGreeting(it.queryParamOrNull("name"))) }
    }

    fun getGreeting(name: String?) = if (name == null) "Hello world!" else "Hello, $name!"
}

fun main(args: Array<String>) {
    runApplication<SpringNativeDemoApplication>(*args)
}
