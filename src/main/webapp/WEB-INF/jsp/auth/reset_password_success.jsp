<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .success-container {
        min-height: 100vh;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
        overflow: hidden;
    }
    
    .success-container::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, rgba(16, 185, 129, 0.08) 0%, rgba(16, 185, 129, 0.03) 100%);
        transform: rotate(30deg);
    }
    
    .success-card {
        max-width: 500px;
        width: 100%;
        background: white;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
        border: 1px solid rgba(16, 185, 129, 0.2);
        overflow: hidden;
        animation: slideUp 0.6s ease-out;
        position: relative;
        z-index: 2;
    }
    
    @keyframes slideUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .success-header {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        padding: 50px 30px 40px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }
    
    .success-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url("data:image/svg+xml,%3Csvg width='80' height='80' viewBox='0 0 80 80' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.15'%3E%3Cpath d='M50 50h-6v6h6v-6zm-28-8h22v-6H22v6zm28-6h-6v6h6v-6zm-6-6h-6v6h6v-6zm-12 0h-6v6h6v-6zm-6 12h-6v6h6v-6zm18-18v6h-6v-6h6zm-24 0v6h-6v-6h6zm12 0v6h-6v-6h6zm12 36h-6v6h6v-6zm-24 0h-6v6h6v-6zm24-12h-6v6h6v-6zm-24 0h-6v6h6v-6zm12 0h-6v6h6v-6zM16 16h6v6h-6v-6zm36 36h6v6h-6v-6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    }
    
    .success-icon-wrapper {
        width: 100px;
        height: 100px;
        background: rgba(255, 255, 255, 0.25);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 25px;
        border: 3px solid rgba(255, 255, 255, 0.4);
        backdrop-filter: blur(10px);
        animation: pulseSuccess 2s ease-in-out infinite;
    }
    
    @keyframes pulseSuccess {
        0% {
            box-shadow: 0 0 0 0 rgba(255, 255, 255, 0.4);
            transform: scale(1);
        }
        70% {
            box-shadow: 0 0 0 20px rgba(255, 255, 255, 0);
            transform: scale(1.05);
        }
        100% {
            box-shadow: 0 0 0 0 rgba(255, 255, 255, 0);
            transform: scale(1);
        }
    }
    
    .success-icon {
        font-size: 48px;
        color: white;
        animation: bounceIn 0.8s ease-out;
    }
    
    @keyframes bounceIn {
        0% {
            opacity: 0;
            transform: scale(0.3);
        }
        50% {
            opacity: 1;
            transform: scale(1.1);
        }
        70% {
            transform: scale(0.9);
        }
        100% {
            transform: scale(1);
        }
    }
    
    .success-body {
        padding: 40px;
        text-align: center;
    }
    
    .success-message {
        margin-bottom: 35px;
    }
    
    .confetti {
        position: absolute;
        width: 10px;
        height: 10px;
        background: linear-gradient(45deg, #10b981, #059669);
        border-radius: 50%;
        animation: confettiFall 5s linear infinite;
        opacity: 0.7;
    }
    
    @keyframes confettiFall {
        0% {
            transform: translateY(-100px) rotate(0deg);
            opacity: 0;
        }
        10% {
            opacity: 1;
        }
        90% {
            opacity: 1;
        }
        100% {
            transform: translateY(500px) rotate(360deg);
            opacity: 0;
        }
    }
    
    .countdown-timer {
        background: linear-gradient(135deg, #f0fdf4 0%, #dcfce7 100%);
        border: 2px solid #bbf7d0;
        border-radius: 16px;
        padding: 20px;
        margin: 30px 0;
        position: relative;
        overflow: hidden;
    }
    
    .countdown-timer::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url("data:image/svg+xml,%3Csvg width='40' height='40' viewBox='0 0 40 40' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%2310b981' fill-opacity='0.05'%3E%3Cpath d='M0 40L40 0H20L0 20M40 40V20L20 40'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    }
    
    .timer-display {
        font-family: 'Courier New', monospace;
        font-size: 2rem;
        font-weight: 700;
        color: #059669;
        letter-spacing: 2px;
        margin: 15px 0;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        position: relative;
        z-index: 1;
    }
    
    .action-buttons {
        display: flex;
        flex-direction: column;
        gap: 15px;
        margin-top: 30px;
    }
    
    .btn-login-now {
        background: linear-gradient(to right, #10b981, #059669);
        border: none;
        padding: 16px 32px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 12px;
        width: 100%;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        color: white;
        text-decoration: none;
    }
    
    .btn-login-now:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(16, 185, 129, 0.3);
        color: white;
        text-decoration: none;
    }
    
    .btn-home {
        background: white;
        border: 2px solid #10b981;
        padding: 14px 32px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 12px;
        width: 100%;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        color: #10b981;
        text-decoration: none;
    }
    
    .btn-home:hover {
        background: #f0fdf4;
        transform: translateY(-2px);
        color: #10b981;
        text-decoration: none;
    }
    
    .security-checklist {
        background: #fff3cd;
        border: 1px solid #ffecb5;
        border-radius: 12px;
        padding: 20px;
        margin-top: 30px;
        text-align: left;
    }
    
    .security-checklist h6 {
        color: #856404;
        font-weight: 600;
        margin-bottom: 15px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .checklist-item {
        display: flex;
        align-items: flex-start;
        gap: 10px;
        margin-bottom: 12px;
        padding-bottom: 12px;
        border-bottom: 1px dashed #ffecb5;
    }
    
    .checklist-item:last-child {
        margin-bottom: 0;
        padding-bottom: 0;
        border-bottom: none;
    }
    
    .checklist-icon {
        color: #10b981;
        font-size: 16px;
        margin-top: 2px;
        flex-shrink: 0;
    }
    
    .checklist-text {
        font-size: 13px;
        color: #856404;
    }
    
    .success-details {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 20px;
        margin: 25px 0;
        text-align: left;
    }
    
    .detail-item {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 12px;
    }
    
    .detail-item:last-child {
        margin-bottom: 0;
    }
    
    .detail-icon {
        width: 32px;
        height: 32px;
        background: white;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #10b981;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        flex-shrink: 0;
    }
    
    .detail-text {
        font-size: 13px;
        color: #6b7280;
    }
    
    .detail-value {
        font-weight: 600;
        color: #374151;
    }
    
    .next-steps {
        margin-top: 25px;
        padding-top: 20px;
        border-top: 1px solid #e5e7eb;
    }
    
    .steps-title {
        font-weight: 600;
        color: #374151;
        margin-bottom: 15px;
        text-align: center;
    }
    
    .steps-list {
        list-style: none;
        padding-left: 0;
        margin-bottom: 0;
    }
    
    .step-item {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 10px;
        padding: 10px 15px;
        background: #f9fafb;
        border-radius: 8px;
        border-left: 3px solid #10b981;
    }
    
    .step-number {
        width: 24px;
        height: 24px;
        background: #10b981;
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: 600;
        flex-shrink: 0;
    }
    
    .step-text {
        font-size: 13px;
        color: #6b7280;
    }
    
    .auto-redirect {
        text-align: center;
        margin-top: 20px;
        padding: 15px;
        background: linear-gradient(135deg, #f0f9ff 0%, #e6f7f0 100%);
        border-radius: 12px;
        border: 1px dashed #10b981;
    }
    
    .redirect-text {
        font-size: 14px;
        color: #059669;
        font-weight: 500;
    }
    
    @media (max-width: 576px) {
        .success-card {
            margin: 0 15px;
        }
        
        .success-body {
            padding: 30px 20px;
        }
        
        .success-header {
            padding: 40px 20px 30px;
        }
        
        .success-icon-wrapper {
            width: 80px;
            height: 80px;
        }
        
        .success-icon {
            font-size: 36px;
        }
        
        .timer-display {
            font-size: 1.5rem;
        }
        
        .action-buttons {
            gap: 12px;
        }
    }
</style>

<div class="success-container">
    <div class="success-card">
        <!-- Header -->
        <div class="success-header">
            <div class="success-icon-wrapper">
                <i class="ri-checkbox-circle-line success-icon"></i>
            </div>
            <h1 class="h3 fw-bold mb-2">Password Reset Successful!</h1>
            <p class="mb-0 opacity-90">Your password has been updated successfully</p>
        </div>
        
        <!-- Body -->
        <div class="success-body">
            <!-- Success Message -->
            <div class="success-message">
                <h2 class="h4 fw-bold text-dark mb-3">🎉 Password Updated Successfully!</h2>
                <p class="text-muted mb-4">
                    Your Lands Commission ELIS account password has been reset successfully. 
                    You can now log in using your new password.
                </p>
                
                <!-- Success Details -->
                <div class="success-details">
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="ri-user-3-line"></i>
                        </div>
                        <div>
                            <div class="detail-text">Account Updated</div>
                            <div class="detail-value">Password successfully changed</div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="ri-time-line"></i>
                        </div>
                        <div>
                            <div class="detail-text">Time of Update</div>
                            <div class="detail-value" id="currentTime"></div>
                        </div>
                    </div>
                    
                    <div class="detail-item">
                        <div class="detail-icon">
                            <i class="ri-shield-check-line"></i>
                        </div>
                        <div>
                            <div class="detail-text">Security Status</div>
                            <div class="detail-value">Enhanced security enabled</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Auto Redirect Timer -->
            <div class="countdown-timer">
                <div class="text-muted fs-14 mb-2">You will be redirected to login in:</div>
                <div class="timer-display" id="redirectTimer">00:10</div>
                <div class="text-muted fs-12">Seconds</div>
            </div>
            
            <!-- Next Steps -->
            <div class="next-steps">
                <div class="steps-title">Next Steps</div>
                <ul class="steps-list">
                    <li class="step-item">
                        <div class="step-number">1</div>
                        <div class="step-text">Log in to your account with your new password</div>
                    </li>
                    <li class="step-item">
                        <div class="step-number">2</div>
                        <div class="step-text">Review your account security settings</div>
                    </li>
                    <li class="step-item">
                        <div class="step-number">3</div>
                        <div class="step-text">Update password in your password manager if used</div>
                    </li>
                </ul>
            </div>
            
            <!-- Action Buttons -->
            <div class="action-buttons">
                <a href="/" class="btn-login-now" id="loginNowBtn">
                    <i class="ri-login-box-line"></i>
                    <span>Log In Now</span>
                </a>
                
                <a href="/" class="btn-home">
                    <i class="ri-home-3-line"></i>
                    <span>Return to Home</span>
                </a>
            </div>
            
            <!-- Security Checklist -->
            <div class="security-checklist">
                <h6>
                    <i class="ri-shield-check-line"></i>
                    Security Recommendations
                </h6>
                <div class="checklist-item">
                    <i class="ri-check-line checklist-icon"></i>
                    <div class="checklist-text">
                        <strong>Use a strong, unique password</strong> that you don't use elsewhere
                    </div>
                </div>
                <div class="checklist-item">
                    <i class="ri-check-line checklist-icon"></i>
                    <div class="checklist-text">
                        <strong>Consider using a password manager</strong> to securely store your credentials
                    </div>
                </div>
                <div class="checklist-item">
                    <i class="ri-check-line checklist-icon"></i>
                    <div class="checklist-text">
                        <strong>Enable two-factor authentication</strong> if available for added security
                    </div>
                </div>
                <div class="checklist-item">
                    <i class="ri-check-line checklist-icon"></i>
                    <div class="checklist-text">
                        <strong>Regularly update your password</strong> every 90 days for optimal security
                    </div>
                </div>
            </div>
            
            <!-- Auto Redirect Notice -->
            <div class="auto-redirect">
                <p class="redirect-text mb-2">
                    <i class="ri-arrow-right-line me-1"></i>
                    <span id="redirectMessage">Auto-redirecting to login in <span id="countdownSeconds">10</span> seconds</span>
                </p>
                <button class="btn btn-link text-decoration-none fs-12 p-0" id="cancelRedirect">
                    Cancel auto-redirect
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Security success message
        console.log("%c✅ PASSWORD RESET SUCCESSFUL ✅", "color: #10b981; font-size: 18px; font-weight: bold;");
        console.log("%cYour password has been reset successfully. Remember to use a strong, unique password.", "color: #fff; background: #059669; padding: 5px;");
        
        // Set current time
        const now = new Date();
        const timeString = now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        const dateString = now.toLocaleDateString();
        $('#currentTime').text(`${dateString} at ${timeString}`);
        
        // Create confetti effect
        createConfetti();
        
        // Countdown timer for auto-redirect
        let countdown = 10;
        let redirectTimer = null;
        const timerElement = $('#redirectTimer');
        const secondsElement = $('#countdownSeconds');
        const cancelBtn = $('#cancelRedirect');
        
        function updateTimer() {
            countdown--;
            
            // Update timer display
            timerElement.text(`00:${countdown.toString().padStart(2, '0')}`);
            secondsElement.text(countdown);
            
            if (countdown <= 0) {
                clearInterval(redirectTimer);
                redirectToLogin();
            }
        }
        
        function startRedirectTimer() {
            redirectTimer = setInterval(updateTimer, 1000);
        }
        
        function redirectToLogin() {
            window.location.href = '/';
        }
        
        function cancelRedirect() {
            clearInterval(redirectTimer);
            $('#redirectMessage').html('<i class="ri-check-line me-1"></i>Auto-redirect cancelled');
            $('.auto-redirect').addClass('bg-light');
            cancelBtn.hide();
        }
        
        // Start the countdown
        startRedirectTimer();
        
        // Cancel redirect on button click
        cancelBtn.on('click', function(e) {
            e.preventDefault();
            cancelRedirect();
        });
        
        // Login now button click
        $('#loginNowBtn').on('click', function(e) {
            e.preventDefault();
            cancelRedirect();
            redirectToLogin();
        });
        
        // Create confetti particles
        function createConfetti() {
            const container = $('.success-header');
            const confettiCount = 30;
            
            for (let i = 0; i < confettiCount; i++) {
                const confetti = $('<div class="confetti"></div>');
                const size = Math.random() * 8 + 4;
                const left = Math.random() * 100;
                const delay = Math.random() * 5;
                const duration = Math.random() * 3 + 3;
                
                confetti.css({
                    width: size+`px`,
                    height: size+`px`,
                    left: left+`%`,
                    animationDelay: delay+`s`,
                    animationDuration: duration+`s`,
                    background: getRandomGradient()
                });
                
                container.append(confetti);
            }
        }
        
        function getRandomGradient() {
            const colors = [
                'linear-gradient(45deg, #10b981, #059669)',
                'linear-gradient(45deg, #34d399, #10b981)',
                'linear-gradient(45deg, #059669, #047857)',
                'linear-gradient(45deg, #a7f3d0, #6ee7b7)'
            ];
            return colors[Math.floor(Math.random() * colors.length)];
        }
        
        // Success animation sequence
        setTimeout(() => {
            $('.success-icon-wrapper').css('animation', 'none');
            setTimeout(() => {
                $('.success-icon-wrapper').css('animation', 'pulseSuccess 2s ease-in-out infinite');
            }, 50);
        }, 2000);
        
        // Add success sound effect (optional)
        function playSuccessSound() {
            // This would require an actual audio file
            // For now, we'll just log a message
            console.log('🔊 Success sound would play here');
        }
        
        // Play sound after a short delay
        setTimeout(playSuccessSound, 500);
        
        // Add keyboard shortcut for immediate login
        $(document).on('keydown', function(e) {
            if (e.key === 'Enter' || e.key === ' ') {
                $('#loginNowBtn').click();
            }
            if (e.key === 'Escape') {
                cancelRedirect();
            }
        });
        
        // Show keyboard shortcuts help
        setTimeout(() => {
            console.log('💡 Tip: Press "Enter" to log in immediately, or "Escape" to cancel auto-redirect');
        }, 2000);
    });
</script>