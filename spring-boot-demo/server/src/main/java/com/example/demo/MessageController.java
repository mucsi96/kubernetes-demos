package com.example.demo;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class MessageController {
    private final MessageConfiguration messageConfiguration;

    @GetMapping("/message")
    public String getMessage() {
        return messageConfiguration.getMessage();
    }
}
