package com.mit.elis.exceptions;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
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

}
