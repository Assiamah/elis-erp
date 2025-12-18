package com.mit.elis.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// import jakarta.net.ssl.SSLContext;
// import jakarta.net.ssl.TrustManager;
// import jakarta.net.ssl.X509TrustManager;
import java.security.cert.X509Certificate;
import java.util.Properties;

@Configuration
public class MailConfig {
    
}
