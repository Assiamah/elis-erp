package com.mit.elis.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mit.elis.services.SmtpMailService;

@RestController
public class MailController {

    private final SmtpMailService emailService;

    public MailController(SmtpMailService emailService) {
        this.emailService = emailService;
    }

    @GetMapping("/send-mail")
    public ResponseEntity<String> sendMail() {
        boolean sent = emailService.sendSimpleMessage(
            "prosper.edem13@gmail.com", 
            "Test Subject from Spring Boot", 
            "Hello, this is a test email from Spring Boot using domain authentication!"
        );
        
        if (sent) {
            return ResponseEntity.ok("Mail Sent Successfully!");
        } else {
            return ResponseEntity.status(500).body("Failed to send email");
        }
    }

    // @GetMapping("/send-html-mail")
    // public ResponseEntity<String> sendHtmlMail() {
    //     String htmlContent = """
    //         <!DOCTYPE html>
    //         <html>
    //         <head>
    //             <style>
    //                 body { font-family: Arial, sans-serif; }
    //                 .header { background-color: #f8f9fa; padding: 20px; text-align: center; }
    //                 .content { padding: 20px; }
    //             </style>
    //         </head>
    //         <body>
    //             <div class="header">
    //                 <h1>Land Commission HR</h1>
    //             </div>
    //             <div class="content">
    //                 <p>Hello,</p>
    //                 <p>This is a <strong>test HTML email</strong> from Spring Boot.</p>
    //                 <p>Best regards,<br>HR Team</p>
    //             </div>
    //         </body>
    //         </html>
    //         """;
        
    //     boolean sent = emailService.sendHtmlMessage(
    //         "prosper.edem13@gmail.com", 
    //         "HTML Test Subject", 
    //         htmlContent
    //     );
        
    //     if (sent) {
    //         return ResponseEntity.ok("HTML Mail Sent Successfully!");
    //     } else {
    //         return ResponseEntity.status(500).body("Failed to send HTML email");
    //     }
    // }
}