package com.mit.elis.config;

import org.springframework.boot.servlet.MultipartConfigFactory;  // Updated import
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.util.unit.DataSize;
import jakarta.servlet.MultipartConfigElement;

@Configuration
public class MultipartConfig {

    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        // Other settings (size limits, etc.)
        factory.setMaxFileSize(DataSize.ofMegabytes(10));  // Example: 10MB per file
        factory.setMaxRequestSize(DataSize.ofMegabytes(50));  // Example: 50MB total request

        // Custom Tomcat-specific limits (via factory properties or reflection if needed)
        // Note: For file count, rely on the properties above or extend if necessary
        return factory.createMultipartConfig();
    }
}