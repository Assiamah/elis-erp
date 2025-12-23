package com.mit.elis.exceptions;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.servlet.NoHandlerFoundException;

import jakarta.servlet.http.HttpServletRequest;

@ControllerAdvice
public class GlobalExceptionHandler {

    // Handle 404 (page not found)
    @ExceptionHandler(NoHandlerFoundException.class)
    public String handleNotFound(NoHandlerFoundException ex, Model model) {
        model.addAttribute("error", "Page not found");
        return "redirect:/?error=notfound";
    }

    // Handle generic errors (500 etc.)
    @ExceptionHandler(Exception.class)
    public String handleGenericError(Exception ex, Model model) {
        model.addAttribute("error", "Something went wrong");
        return "redirect:/?error=server";
    }

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request) {
        // Redirect all errors to index
        return "redirect:/";
    }

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    
    @ExceptionHandler(MultipartException.class)
    public ResponseEntity<Map<String, String>> handleMultipartException(
            MultipartException ex, 
            HttpServletRequest request) {
        
        logger.error("Multipart processing failed for request: {} {}", 
                     request.getMethod(), request.getRequestURI(), ex);
        
        Map<String, String> errorResponse = new HashMap<>();
        errorResponse.put("error", "File upload failed");
        errorResponse.put("message", ex.getMessage());
        errorResponse.put("path", request.getRequestURI());
        
        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .contentType(MediaType.APPLICATION_JSON)
                .body(errorResponse);
    }

}
