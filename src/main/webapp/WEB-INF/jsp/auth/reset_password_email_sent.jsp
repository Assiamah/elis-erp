<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .password-reset-container {
        min-height: 100vh;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
        overflow: hidden;
    }
    
    .password-reset-container::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, rgba(16, 185, 129, 0.05) 0%, rgba(16, 185, 129, 0.02) 100%);
        transform: rotate(30deg);
    }
    
    .password-reset-card {
        max-width: 460px;
        width: 100%;
        background: white;
        border-radius: 20px;
        box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
        border: 1px solid rgba(16, 185, 129, 0.15);
        overflow: hidden;
        animation: slideUp 0.6s ease-out;
        position: relative;
        z-index: 2;
    }
    
    @keyframes slideUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }
    
    .reset-header {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        padding: 40px 30px 30px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }
    
    .reset-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    }
    
    .reset-icon {
        width: 80px;
        height: 80px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 20px;
        border: 2px solid rgba(255, 255, 255, 0.3);
        backdrop-filter: blur(10px);
    }
    
    .reset-icon i {
        font-size: 36px;
    }
    
    .reset-body {
        padding: 40px;
    }
    
    .instruction-box {
        background: linear-gradient(135deg, #f0f9ff 0%, #e6f7f0 100%);
        border: 2px solid #d1fae5;
        border-radius: 16px;
        padding: 25px;
        margin-bottom: 30px;
        position: relative;
    }
    
    .instruction-box::before {
        content: '📧';
        position: absolute;
        top: -15px;
        left: 50%;
        transform: translateX(-50%);
        background: white;
        padding: 5px 15px;
        border-radius: 50px;
        font-size: 14px;
        border: 2px solid #d1fae5;
    }
    
    .step-indicator {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 30px;
        margin-bottom: 25px;
        position: relative;
    }
    
    .step-indicator::before {
        content: '';
        position: absolute;
        top: 15px;
        left: 50%;
        transform: translateX(-50%);
        width: 200px;
        height: 2px;
        background: linear-gradient(to right, #10b981, #059669);
        opacity: 0.3;
    }
    
    .step {
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 8px;
        position: relative;
        z-index: 1;
    }
    
    .step-circle {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        background: white;
        border: 2px solid #e5e7eb;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 14px;
        font-weight: 600;
        color: #9ca3af;
        transition: all 0.3s ease;
    }
    
    .step.active .step-circle {
        background: #10b981;
        border-color: #10b981;
        color: white;
        box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
    }
    
    .step-label {
        font-size: 12px;
        color: #9ca3af;
        font-weight: 500;
    }
    
    .step.active .step-label {
        color: #10b981;
        font-weight: 600;
    }
    
    .form-group {
        margin-bottom: 25px;
    }
    
    .form-label {
        display: flex;
        align-items: center;
        gap: 8px;
        font-weight: 600;
        color: #374151;
        margin-bottom: 10px;
    }
    
    .form-label i {
        color: #10b981;
    }
    
    .email-input-group {
        position: relative;
    }
    
    .email-input {
        padding-left: 50px !important;
        height: 56px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        font-size: 16px;
        transition: all 0.3s ease;
    }
    
    .email-input:focus {
        border-color: #10b981;
        box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.1);
        transform: translateY(-1px);
    }
    
    .email-input::placeholder {
        color: #9ca3af;
    }
    
    .email-icon {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        color: #10b981;
        font-size: 20px;
        z-index: 2;
    }
    
    .btn-reset {
        background: linear-gradient(to right, #10b981, #059669);
        border: none;
        padding: 16px 32px;
        font-size: 16px;
        font-weight: 600;
        border-radius: 12px;
        width: 100%;
        transition: all 0.3s ease;
        position: relative;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
    }
    
    .btn-reset:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(16, 185, 129, 0.3);
        background: linear-gradient(to right, #0da271, #047857);
    }
    
    .btn-reset:disabled {
        opacity: 0.7;
        transform: none;
        box-shadow: none;
    }
    
    .btn-reset .spinner {
        display: none;
        width: 20px;
        height: 20px;
        border: 3px solid rgba(255, 255, 255, 0.3);
        border-radius: 50%;
        border-top-color: white;
        animation: spin 1s ease-in-out infinite;
    }
    
    .btn-reset.loading .text {
        display: none;
    }
    
    .btn-reset.loading .spinner {
        display: block;
    }
    
    .alternate-option {
        text-align: center;
        margin-top: 25px;
        padding-top: 20px;
        border-top: 1px solid #e5e7eb;
    }
    
    .alternate-link {
        color: #10b981;
        font-weight: 600;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        transition: all 0.3s ease;
    }
    
    .alternate-link:hover {
        color: #047857;
        text-decoration: underline;
    }
    
    .back-to-login {
        text-align: center;
        margin-top: 20px;
    }
    
    .back-link {
        color: #6b7280;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        font-size: 14px;
    }
    
    .back-link:hover {
        color: #10b981;
        text-decoration: underline;
    }
    
    .success-message {
        background: linear-gradient(135deg, #d1fae5 0%, #a7f3d0 100%);
        border: 2px solid #10b981;
        border-radius: 16px;
        padding: 25px;
        margin-bottom: 25px;
        text-align: center;
        animation: fadeIn 0.5s ease-out;
        display: none;
    }
    
    .success-message.show {
        display: block;
    }
    
    .success-icon {
        font-size: 48px;
        color: #10b981;
        margin-bottom: 15px;
        animation: bounce 0.6s ease-out;
    }
    
    @keyframes bounce {
        0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
        40% {transform: translateY(-10px);}
        60% {transform: translateY(-5px);}
    }
    
    .security-tips {
        background: #fff3cd;
        border: 1px solid #ffecb5;
        border-radius: 12px;
        padding: 20px;
        margin-top: 25px;
        font-size: 13px;
        color: #856404;
    }
    
    .security-tips h6 {
        color: #856404;
        font-weight: 600;
        margin-bottom: 10px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    .tips-list {
        list-style: none;
        padding-left: 0;
        margin-bottom: 0;
    }
    
    .tips-list li {
        margin-bottom: 6px;
        display: flex;
        align-items: flex-start;
        gap: 8px;
    }
    
    .tips-list li:last-child {
        margin-bottom: 0;
    }
    
    .tips-list i {
        color: #10b981;
        font-size: 14px;
        margin-top: 2px;
    }
    
    @media (max-width: 576px) {
        .password-reset-card {
            margin: 0 15px;
        }
        
        .reset-body {
            padding: 30px 20px;
        }
        
        .instruction-box {
            padding: 20px 15px;
        }
        
        .step-indicator {
            gap: 20px;
        }
        
        .step-indicator::before {
            width: 150px;
        }
    }
</style>

<div class="password-reset-container">
    <div class="password-reset-card">
        <div class="reset-header">
            <div class="reset-icon">
                <i class="ri-mail-check-line"></i>
            </div>
            <h1 class="h4 fw-bold mb-2">Check Your Email</h1>
            <p class="mb-0 opacity-90">Password reset instructions have been sent</p>
        </div>
        
        <div class="reset-body">
            <div class="success-message show">
                <div class="success-icon">
                    <i class="ri-mail-send-line"></i>
                </div>
                <h6 class="fw-bold text-dark mb-2">Email Sent Successfully</h6>
                <p class="mb-3 text-muted fw-light small">
                    We've sent password reset instructions to:
                    <br>
                    <strong class="text-primary">${user_email}</strong>
                </p>
                <p class="fs-14 mb-0 fw-light small">
                    Please check your inbox and click the link in the email to reset your password.
                </p>
            </div>
            
            <div class="instruction-box mt-4">
                <h6 class="fw-bold text-dark mb-3">
                    <i class="ri-information-line me-2"></i>
                    Didn't receive the email?
                </h6>
                <ul class="mb-0 ps-3 small fw-light">
                    <li class="mb-2">Check your spam or junk folder</li>
                    <li class="mb-2">Make sure you entered the correct email address</li>
                    <li>Wait a few minutes and try again</li>
                </ul>
            </div>
            
            <div class="d-grid gap-3 mt-4">
                <a href="/" class="btn btn-outline-success">
                    <i class="ri-arrow-left-line me-2"></i>
                    Back to Login
                </a>
                <a href="forgot_password" class="btn btn-light">
                    <i class="ri-refresh-line me-2"></i>
                    Try Another Email
                </a>
            </div>
            
            <div class="security-tips mt-4">
                <h6 class="smal">
                    <i class="ri-shield-keyhole-line"></i>
                    Security Reminder
                </h6>
                <ul class="tips-list small fw-light">
                    <li>
                        <i class="ri-check-line"></i>
                        The reset link expires in 24 hours
                    </li>
                    <li>
                        <i class="ri-check-line"></i>
                        Never share your reset link with anyone
                    </li>
                    <li>
                        <i class="ri-check-line"></i>
                        Contact IT support if you didn't request this reset
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Security warning
        console.log("%c🔐 PASSWORD RESET PORTAL 🔐", "color: #10b981; font-size: 18px; font-weight: bold;");
        console.log("%cThis is a secure password reset system. Only use your official email address.", "color: #fff; background: #059669; padding: 5px;");
        
        // Form submission
        $('#resetForm').on('submit', function(e) {
            e.preventDefault();
            
            const btn = $('#btnReset');
            const email = $('#email').val().trim();
            
            // Validate email format
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailPattern.test(email)) {
                alert('Please enter a valid email address');
                $('#email').focus();
                return;
            }
            
            // Show loading state
            btn.addClass('loading');
            btn.prop('disabled', true);
            
            // Simulate API call (replace with actual submission)
            setTimeout(() => {
                // Show success message
                $('#successMessage').addClass('show');
                $('#instructionBox').hide();
                $('#resetForm').hide();
                
                // Update steps
                $('.step').removeClass('active');
                $('.step:nth-child(2)').addClass('active');
                
                // Reset button state
                btn.removeClass('loading');
                btn.prop('disabled', false);
                
                // Show confirmation message
                // console.log(`Reset link sent to: ${email}`);
                
                // In production, you would submit the form here:
                this.submit();
                
            }, 2000);
        });
        
        // Email input validation
        $('#email').on('blur', function() {
            const email = $(this).val().trim();
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            
            if (email && !emailPattern.test(email)) {
                $(this).addClass('is-invalid');
                $(this).removeClass('is-valid');
            } else if (email && emailPattern.test(email)) {
                $(this).removeClass('is-invalid');
                $(this).addClass('is-valid');
            } else {
                $(this).removeClass('is-invalid is-valid');
            }
        });
        
        // Real-time validation
        $('#email').on('input', function() {
            const email = $(this).val().trim();
            const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            
            if (email && emailPattern.test(email)) {
                $(this).removeClass('is-invalid');
                $(this).addClass('is-valid');
            } else if (email && !emailPattern.test(email)) {
                $(this).addClass('is-invalid');
                $(this).removeClass('is-valid');
            } else {
                $(this).removeClass('is-invalid is-valid');
            }
        });
        
        // Focus email input on page load
        setTimeout(() => {
            $('#email').focus();
        }, 500);
        
        // Enter key submission
        $('#email').on('keypress', function(e) {
            if (e.which === 13) {
                $('#resetForm').submit();
            }
        });
        
        // Contact admin link
        $('.alternate-link').on('click', function(e) {
            e.preventDefault();
            
            Swal.fire({
                title: '<strong>Contact System Administrator</strong>',
                html: `
                    <div class="text-start">
                        <div class="mb-4">
                            <h6 class="text-primary fw-semibold mb-2">For password reset assistance, contact:</h6>
                        </div>
                        
                        <div class="contact-details mb-4">
                            <div class="d-flex align-items-start mb-3">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-building-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">IT Support Department</div>
                                    <div class="fw-semibold">Lands Commission Headquarters</div>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-start mb-3">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-mail-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">Email Address</div>
                                    <div class="fw-semibold">itsupport@lc.gov.gh</div>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-start mb-3">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-phone-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">Phone Number</div>
                                    <div class="fw-semibold">+233 30 123 4567</div>
                                </div>
                            </div>
                            
                            <div class="d-flex align-items-start">
                                <div class="flex-shrink-0 me-3">
                                    <i class="ri-time-line fs-18 text-success"></i>
                                </div>
                                <div>
                                    <div class="fw-medium text-muted fs-13 mb-1">Office Hours</div>
                                    <div class="fw-semibold">Monday - Friday</div>
                                    <div class="text-muted fs-13">8:00 AM - 5:00 PM (GMT)</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="alert alert-warning border-warning border-start-3 border-0 bg-light p-3 mt-3 mb-0">
                            <div class="d-flex">
                                <i class="ri-information-line fs-18 text-warning me-2"></i>
                                <div class="fs-13">
                                    <strong>Note:</strong> Please have your employee ID ready when contacting support for faster assistance.
                                </div>
                            </div>
                        </div>
                    </div>
                `,
                icon: 'info',
                showCloseButton: true,
                showCancelButton: false,
                confirmButtonText: 'Got it',
                confirmButtonColor: '#10b981',
                width: '500px',
                padding: '1.5rem',
                customClass: {
                    popup: 'border-radius-16',
                    title: 'mb-3',
                    htmlContainer: 'text-dark'
                }
            });
        });
    });
</script>