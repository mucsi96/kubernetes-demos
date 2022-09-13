package com.example.demo;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessageController {
    private final String message;

    MessageController(
            @Value("#{environment.MESSAGE}") String message
    ) {
        this.message = message;
    }

    @GetMapping("/message")
    public String getMessage() {
        return this.message;
    }
}
