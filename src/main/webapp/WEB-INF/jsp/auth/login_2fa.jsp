<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .verification-container {
        min-height: 100vh;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
    }
    
    .verification-card {
        max-width: 500px;
        width: 100%;
        background: white;
        border-radius: 16px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.08);
        border: 1px solid rgba(16, 185, 129, 0.1);
        overflow: hidden;
        animation: fadeIn 0.6s ease-out;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .verification-header {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        padding: 30px;
        text-align: center;
    }
    
    .verification-logo {
        width: 60px;
        height: 60px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
    }
    
    .verification-body {
        padding: 40px;
    }
    
    .otp-display {
        background: linear-gradient(135deg, #f0f9ff 0%, #e6f7f0 100%);
        border: 2px dashed #10b981;
        border-radius: 12px;
        padding: 20px;
        text-align: center;
        margin: 25px 0;
    }
    
    .otp-code {
        font-family: 'Courier New', monospace;
        font-size: 2.5rem;
        font-weight: 700;
        color: #059669;
        letter-spacing: 8px;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    .timer-display {
        font-size: 1rem;
        font-weight: 600;
        color: #10b981;
        background: white;
        padding: 5px 30px;
        border-radius: 50px;
        display: inline-block;
        border: 2px solid #e6f7f0;
        min-width: 120px;
        transition: all 0.3s ease;
    }
    
    .timer-display.expired {
        color: #dc3545;
        border-color: #f8d7da;
        background: #f8d7da;
    }
    
    .otp-input-group {
        display: flex;
        gap: 12px;
        justify-content: center;
        margin: 30px 0;
    }
    
    .otp-input {
        width: 60px !important;
        height: 60px !important;
        text-align: center;
        font-size: 1.5rem;
        font-weight: 600;
        border: 2px solid #e5e7eb;
        border-radius: 10px;
        background: white;
        transition: all 0.3s ease;
    }
    
    .otp-input:focus {
        border-color: #10b981;
        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        transform: translateY(-2px);
    }
    
    .otp-input.filled {
        border-color: #10b981;
        background: #f0fdf4;
    }
    
    .contact-info {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 20px;
        margin: 25px 0;
    }
    
    .contact-item {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 12px;
    }
    
    .contact-item:last-child {
        margin-bottom: 0;
    }
    
    .contact-icon {
        width: 36px;
        height: 36px;
        background: white;
        border-radius: 8px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #10b981;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }
    
    .btn-verify {
        background: linear-gradient(to right, #10b981, #059669);
        border: none;
        padding: 14px 28px;
        font-size: 1.1rem;
        font-weight: 600;
        border-radius: 10px;
        width: 100%;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
    }
    
    .btn-verify:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3);
    }
    
    .btn-verify:disabled {
        opacity: 0.7;
        transform: none;
        box-shadow: none;
    }
    
    .btn-verify::after {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
        transition: 0.5s;
    }
    
    .btn-verify:hover::after {
        left: 100%;
    }
    
    .resend-link {
        color: #10b981;
        font-weight: 600;
        text-decoration: none;
        cursor: pointer;
        transition: all 0.3s ease;
    }
    
    .resend-link:hover {
        color: #047857;
        text-decoration: underline;
    }
    
    .back-link {
        color: #6b7280;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.3s ease;
    }
    
    .back-link:hover {
        color: #10b981;
        text-decoration: underline;
    }
    
    .masked-text {
        font-family: 'Courier New', monospace;
        color: #374151;
        background: #f3f4f6;
        padding: 2px 8px;
        border-radius: 4px;
    }
    
    .security-note {
        background: #fff3cd;
        border: 1px solid #ffecb5;
        border-radius: 8px;
        padding: 15px;
        margin: 25px 0;
        font-size: 0.9rem;
        color: #856404;
    }
    
    .loading-spinner {
        display: inline-block;
        width: 20px;
        height: 20px;
        border: 3px solid rgba(255, 255, 255, 0.3);
        border-radius: 50%;
        border-top-color: white;
        animation: spin 1s ease-in-out infinite;
    }
    
    @keyframes spin {
        to { transform: rotate(360deg); }
    }
</style>

<div class="verification-container">
    <div class="verification-card">
        <!-- Header -->
        <div class="verification-header mb-0">
            <!-- <div class="verification-logo">
                <i class="ri-shield-check-line fs-24"></i>
            </div> -->
            <h1 class="h4 text-white fw-bold mb-0"><i class="ri-shield-check-line fs-24 me-2"></i>Two-Factor Verification</h1>
            <!-- <p class="mb-0 opacity-90">Enhanced account security</p> -->
        </div>
        
        <!-- Body -->
        <div class="verification-body mt-0">
            
            <!-- Title -->
            <!-- <div class="text-center mb-4">
                <h2 class="h4 fw-bold text-dark mb-2">Verify Your Identity</h2>
                <p class="text-muted mb-0">Enter the 6-digit code sent to your registered contact methods</p>
            </div> -->
            
            <!-- Contact Information -->
             <h2 class="fw-medium">${otp_code}</h2>
            <div class="contact-info">
                <h6 class="fw-semibold mb-3 text-dark">
                    <i class="ri-mail-send-line me-2"></i>
                    Code sent to:
                </h6>
                <div class="contact-item">
                    <div class="contact-icon">
                        <i class="ri-smartphone-line"></i>
                    </div>
                    <div>
                        <div class="fs-12 text-muted">SMS to mobile number</div>
                        <div class="fw-medium masked-text" id="phone_number">${user_phone}</div>
                    </div>
                </div>
                <div class="contact-item">
                    <div class="contact-icon">
                        <i class="ri-mail-line"></i>
                    </div>
                    <div>
                        <div class="fs-12 text-muted">Email to your address</div>
                        <div class="fw-medium masked-text" id="user_emailaddress"></div>
                    </div>
                </div>
            </div>

            <!-- Security Status -->
            <div class="d-flex align-items-center justify-content-between mb-4">
                <div class="d-flex align-items-center gap-2">
                    <div class="badge bg-success bg-opacity-10 text-success py-2 px-3 rounded-pill">
                        <i class="ri-shield-check-line me-1"></i>
                        Secure Verification
                    </div>
                </div>
                <div id="timer" class="timer-display">10:00</div>
            </div>
            
            <!-- Security Note -->
            <div class="security-note">
                <div class="d-flex align-items-start">
                    <i class="ri-alert-line me-2 fs-18"></i>
                    <div>
                        <strong class="d-block mb-1">Security Notice:</strong>
                        <p class="mb-0 fs-12">For security reasons, never share this code with anyone. The code is valid for 10 minutes only.</p>
                    </div>
                </div>
            </div>
            
            <!-- OTP Input Form -->
            <form name="loginForm" id="loginForm" method="POST" action="Login" novalidate>
                <!-- OTP Inputs -->
                <div class="mb-4">
                    <label class="form-label fw-semibold mb-1">Enter 6-digit verification code:</label>
                    <div class="otp-input-group">
                        <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_1" name="vc_1" maxlength="1" onkeyup="clickEvent(this,'vc_2')" autofocus>
                        <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_2" name="vc_2" maxlength="1" onkeyup="clickEvent(this,'vc_3')">
                        <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_3" name="vc_3" maxlength="1" onkeyup="clickEvent(this,'vc_4')">
                        <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_4" name="vc_4" maxlength="1" onkeyup="clickEvent(this,'vc_5')">
                        <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_5" name="vc_5" maxlength="1" onkeyup="clickEvent(this,'vc_6')">
                        <input type="text" inputmode="numeric" pattern="[0-9]*" class="form-control otp-input" id="vc_6" name="vc_6" maxlength="1">
                    </div>
                </div>
                
                <!-- Resend Option -->
                <div class="text-center mb-4">
                    <p class="text-muted mb-2">Did not receive a code?</p>
                    <a href="#" class="resend-link d-inline-flex align-items-center gap-2" id="resendLink" onclick="resendOTP()">
                        <i class="ri-refresh-line"></i>
                        <span>Resend Verification Code</span>
                    </a>
                </div>
                
                <!-- Submit Button -->
                <div class="d-grid mb-4">
                    <button type="submit" id="btn-verify" class="btn btn-primary btn-lg">
                        <span class="button-text">
                            <i class="ri-shield-check-line me-2"></i>
                            Verify & Continue
                        </span>
                        <span class="loading-text d-none">
                            <span class="mdi mdi-spin mdi-loading me-1" role="status"></span>
                            Verifying...
                        </span>
                    </button>
                </div>
            </form>
            
            <!-- Back to Login -->
            <div class="text-center pt-3 border-top">
                <a href="/" class="back-link">
                    <i class="ri-arrow-left-line"></i>
                    <span>Return to Login Page</span>
                </a>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Security warning
        console.log("%c🔐 SECURITY VERIFICATION 🔐", "color: #10b981; font-size: 18px; font-weight: bold;");
        console.log("%cThis is a secure verification page. Do not enter codes from untrusted sources.", "color: #fff; background: #059669; padding: 5px;");
        
        // Mask phone number
        let str = document.getElementById("phone_number").innerHTML;
        let res = str.replace(/\d(?=\d{3})/g, "*");
        document.getElementById("phone_number").innerHTML = res;
        
        // Mask email
        function maskEmail(email) {
            const [user, domain] = email.split("@");
            const maskedUser = user.substring(0, 2) + "*".repeat(Math.max(user.length - 2, 0));
            const [domainName, domainExt] = domain.split(".");
            const maskedDomain = domainName.substring(0, 1) + "***" + "." + domainExt;
            return maskedUser + "@" + maskedDomain;
        }
        
        const email = "${user_emailaddress}";
        document.getElementById("user_emailaddress").innerText = maskEmail(email);
        
        // Timer functionality
        const KEY = "otpCountdownTarget";
        const DURATION = 60*10;
        const timerEl = document.getElementById("timer");
        // const timerTextEl = document.getElementById("timer-text");
        const resendLink = document.getElementById("resendLink");
        let intervalId = null;
        
        function formatMMSS(totalSeconds) {
            const m = Math.floor(totalSeconds / 60).toString().padStart(2, "0");
            const s = Math.floor(totalSeconds % 60).toString().padStart(2, "0");
            return m+':'+s;
        }
        
        function getOrCreateTarget(fromNowSeconds = DURATION) {
            let t = localStorage.getItem(KEY);
            const now = Date.now();
            if (!t || Number(t) <= now) {
                t = String(now + fromNowSeconds * 1000);
                localStorage.setItem(KEY, t);
                resendLink.style.pointerEvents = 'none';
                resendLink.style.opacity = '0.5';
            }
            return Number(t);
        }
        
        function startCountdown() {
            const target = getOrCreateTarget();
            updateUI(target);
            if (intervalId) clearInterval(intervalId);
            intervalId = setInterval(() => updateUI(Number(localStorage.getItem(KEY))), 250);
        }
        
        function updateUI(targetTs) {
            const now = Date.now();
            const remaining = Math.max(0, Math.ceil((targetTs - now) / 1000));
            const formatted = formatMMSS(remaining);
            timerEl.textContent = formatted;
            //timerTextEl.textContent = formatted;
            
            if (remaining <= 0 && intervalId) {
                clearInterval(intervalId);
                intervalId = null;
                localStorage.removeItem(KEY);
                timerEl.textContent = "Expired";
                timerEl.classList.add('expired');
                //timerTextEl.textContent = "expired";
                resendLink.style.pointerEvents = 'auto';
                resendLink.style.opacity = '1';
            }
        }
        
        // OTP input handling
        const otpInputs = document.querySelectorAll('.otp-input');
        
        otpInputs.forEach((input, index) => {
            input.addEventListener('input', (e) => {
                const value = e.target.value;
                if (/^\d$/.test(value)) {
                    input.classList.add('filled');
                    if (index < otpInputs.length - 1) {
                        otpInputs[index + 1].focus();
                    } else {
                        // Auto-submit when all fields are filled
                        setTimeout(() => {
                            document.getElementById("btn-verify").click();
                        }, 500);
                    }
                } else if (value === '') {
                    input.classList.remove('filled');
                }
            });
            
            input.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && input.value === '' && index > 0) {
                    otpInputs[index - 1].focus();
                    otpInputs[index - 1].classList.remove('filled');
                }
            });
            
            input.addEventListener('paste', (e) => {
                e.preventDefault();
                const pasteData = e.clipboardData.getData('text').slice(0, 6);
                const digits = pasteData.match(/\d/g) || [];
                
                digits.forEach((digit, idx) => {
                    if (otpInputs[idx]) {
                        otpInputs[idx].value = digit;
                        otpInputs[idx].classList.add('filled');
                    }
                });
                
                if (digits.length === 6) {
                    otpInputs[5].focus();
                } else if (digits.length > 0) {
                    otpInputs[digits.length].focus();
                }
            });
        });
        
        // Form submission
        document.getElementById('loginForm').addEventListener('submit', function (e) {
            e.preventDefault();
            
            const btn = $('#btn-verify');
            const buttonText = btn.find('.button-text');
            const loadingText = btn.find('.loading-text');
            
            // Show loading state
            buttonText.addClass('d-none');
            loadingText.removeClass('d-none');
            btn.prop('disabled', true);
            
            // Validate OTP
            const otp = Array.from(otpInputs).map(input => input.value).join('');
            if (otp.length !== 6) {
                alert('Please enter the complete 6-digit code');
                buttonText.removeClass('d-none');
                loadingText.addClass('d-none');
                btn.prop('disabled', false);
                return;
            }
            
            // Submit form after validation
            setTimeout(() => {
                this.submit();
            }, 1000);
        });
        
        // Resend OTP function
        window.resendOTP = function() {
            if (resendLink.style.pointerEvents === 'none') return;
            
            // Show loading on resend link
            const originalText = resendLink.innerHTML;
            resendLink.innerHTML = '<i class="ri-refresh-line"></i><span>Sending new code...</span>';
            resendLink.style.pointerEvents = 'none';
            
            // Reset timer
            localStorage.removeItem(KEY);
            
            // Simulate API call and reset timer
            setTimeout(() => {
                startCountdown();
                resendLink.innerHTML = originalText;
                resendLink.style.pointerEvents = 'auto';
                
                // Show success message (you can replace with toast notification)
                alert('New verification code has been sent to your registered contact methods.');
            }, 1500);
        };
        
        // Start timer on load
        startCountdown();
        
        // Sync across tabs
        window.addEventListener("storage", (e) => {
            if (e.key === KEY) {
                const t = localStorage.getItem(KEY);
                if (t) updateUI(Number(t));
            }
        });
        
        // Focus first OTP input
        setTimeout(() => {
            otpInputs[0].focus();
        }, 500);
    });
    
    // Legacy function for backward compatibility
    function clickEvent(current, nextFieldID) {
        if (current.value.length === 1) {
            document.getElementById(nextFieldID).focus();
            document.getElementById(nextFieldID).classList.add('filled');
        }
    }
</script>