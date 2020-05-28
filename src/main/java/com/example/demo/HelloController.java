package com.example.demo;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    @GetMapping("/")
    public ResponseEntity<String> getGreeting(@RequestParam(defaultValue = "Cletus") String name) {
        return ResponseEntity.ok(String.format("Hello my cool %s", name));
    }
}
