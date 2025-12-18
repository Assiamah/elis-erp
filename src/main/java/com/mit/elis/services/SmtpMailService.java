package com.mit.elis.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.mail.internet.MimeMessage;
import java.time.Year;

@Service
public class SmtpMailService {

    private static final Logger logger = LoggerFactory.getLogger(SmtpMailService.class);

    private final JavaMailSender mailSender;

    @Value("${spring.mail.from.address}")
    private String fromAddress;

    @Value("${spring.mail.from.name}")
    private String fromName;

    public SmtpMailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public boolean sendSimpleMessage(String to, String subject, String text) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromAddress);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(text);

            mailSender.send(message);
            logger.info("Email sent successfully to: {}", to);
            return true;

        } catch (Exception e) {
            logger.error("Failed to send email to: {}, Error: {}", to, e.getMessage());
            return false;
        }
    }

    // Method with HTML support
    public boolean sendHtmlMessage(String to, String subject, String htmlContent) {
        try {
            jakarta.mail.internet.MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom(fromAddress, fromName);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlContent, true); // true indicates HTML

            mailSender.send(mimeMessage);
            logger.info("HTML email sent successfully to: {}", to);
            return true;

        } catch (Exception e) {
            logger.error("Failed to send HTML email to: {}, Error: {}", to, e.getMessage());
            return false;
        }
    }

    // Method to send OTP email without Thymeleaf
    public boolean sendOtpEmail(String to, String userFirstName, String otp, String otpLabel) {
        try {
            String htmlContent = buildOtpEmailHtml(userFirstName, otp, otpLabel);

            jakarta.mail.internet.MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom(fromAddress, fromName);
            helper.setTo(to);
            helper.setSubject("LC - Verification Code");
            helper.setText(htmlContent, true);

            mailSender.send(mimeMessage);
            logger.info("OTP email sent successfully to: {}", to);
            return true;

        } catch (Exception e) {
            logger.error("Failed to send OTP email to: {}, Error: {}", to, e.getMessage());
            return false;
        }
    }

    private String buildOtpEmailHtml(String userFirstName, String otp, String otpLabel) {
        return "<!DOCTYPE html>\n" +
                "<html>\n" +
                "<head>\n" +
                "    <title>LC - Verification Code</title>\n" +
                "    <style>\n" +
                "        body { font-family: Arial, sans-serif; line-height: 1.6; margin: 0; padding: 20px; background-color: #f4f4f4; }\n"
                +
                "        .container { max-width: 600px; margin: 0 auto; background-color: #ffffff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }\n"
                +
                "        .header { text-align: center; margin-bottom: 25px; padding-bottom: 20px; border-bottom: 2px solid #e9ecef; }\n"
                +
                "        .logo { max-width: 150px; margin-bottom: 15px; }\n" +
                "        .footer { margin-top: 30px; font-size: 0.9em; color: #666; text-align: center; padding-top: 20px; border-top: 1px solid #e9ecef; }\n"
                +
                "        .otp-container { background-color: #f8f9fa; padding: 20px; border-left: 4px solid rgb(106, 174, 76); margin: 25px 0; border-radius: 4px; }\n"
                +
                "        .otp-code { font-size: 28px; font-weight: bold; color:rgb(106, 174, 76); letter-spacing: 3px; margin: 15px 0; text-align: center; }\n"
                +
                "        .greeting { color: #333; font-size: 16px; margin-bottom: 20px; }\n" +
                "        .instruction { color: #666; margin-bottom: 10px; }\n" +
                "       .logo { float: center; width: 50px; padding-right: 10px; padding-bottom: 5px;}" +
                "    </style>\n" +
                "</head>\n" +
                "<body>\n" +
                "    <div class=\"container\">\n" +
                "        <div class=\"header\">\n" +
                "           <img class='logo' src='https://i.ibb.co/TBJ8BGcZ/NewLogo.png' alt='Logo' >" +
                "            <h2 style=\"color: #2c3e50; margin: 0;\">LC - Verification Code</h2>\n" +
                "        </div>\n" +
                "\n" +
                "        <p class=\"greeting\">Hello <strong>" + userFirstName + "</strong>,</p>\n" +
                "\n" +
                "        <div class=\"otp-container\">\n" +
                "            <p class=\"instruction\"><strong>Verification Code:</strong></p>\n" +
                "            <p class=\"instruction\">" + otpLabel + "</p>\n" +
                "            <div class=\"otp-code\">" + otp + "</div>\n" +
                "            <p class=\"instruction\" style=\"font-size: 12px; color: #999; margin-top: 15px;\">\n" +
                "                This code will expire in 10 minutes. Please do not disclose this code to others. If you did not make this request, please disregard this email.\n"
                +
                "            </p>\n" +
                "        </div>\n" +
                "\n" +
                "        <div class=\"footer\">\n" +
                "            <p>This is an automated notification. Please do not reply directly to this email.</p>\n" +
                "            <p>&copy; " + Year.now() + " Lands Commission. All rights reserved.</p>\n" +
                "        </div>\n" +
                "    </div>\n" +
                "</body>\n" +
                "</html>";
    }

    // Optional: Method to send OTP email with custom subject
    public boolean sendOtpEmail(String to, String userFirstName, String otp, String otpLabel, String subject) {
        try {
            String htmlContent = buildOtpEmailHtml(userFirstName, otp, otpLabel);

            jakarta.mail.internet.MimeMessage mimeMessage = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

            helper.setFrom(fromAddress, fromName);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(htmlContent, true);

            mailSender.send(mimeMessage);
            logger.info("OTP email with custom subject sent successfully to: {}", to);
            return true;

        } catch (Exception e) {
            logger.error("Failed to send OTP email to: {}, Error: {}", to, e.getMessage());
            return false;
        }
    }
}