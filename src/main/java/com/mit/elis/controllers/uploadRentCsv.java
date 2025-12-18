package com.mit.elis.controllers;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

public class uploadRentCsv {
    @PostMapping("/uploadRentCsv")
public ResponseEntity<String> uploadRentCsv(
        @RequestParam("csvFile") MultipartFile file,
        @RequestParam("region") String region,
        @RequestParam("estate") String estate) {

    if (file.isEmpty()) {
        return ResponseEntity.badRequest().body("No file uploaded.");
    }

    try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream()))) {
        String line;
        while ((line = reader.readLine()) != null) {
            System.out.println("CSV Line: " + line);
        }
    } catch (IOException e) {
        return ResponseEntity.internalServerError().body("Error reading file: " + e.getMessage());
    }

    return ResponseEntity.ok("CSV uploaded successfully.");
}
}

