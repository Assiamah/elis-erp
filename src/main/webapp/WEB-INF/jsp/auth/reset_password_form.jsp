<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .password-reset-form-container {
        min-height: 100vh;
        background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 20px;
        position: relative;
        overflow: hidden;
    }
    
    .password-reset-form-container::before {
        content: '';
        position: absolute;
        top: -50%;
        right: -50%;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, rgba(16, 185, 129, 0.05) 0%, rgba(16, 185, 129, 0.02) 100%);
        transform: rotate(30deg);
    }
    
    .reset-form-card {
        max-width: 480px;
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
    
    .reset-form-header {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        padding: 35px 30px 25px;
        text-align: center;
        position: relative;
        overflow: hidden;
    }
    
    .reset-form-header::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.1'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
    }
    
    .reset-form-icon {
        width: 70px;
        height: 70px;
        background: rgba(255, 255, 255, 0.2);
        border-radius: 18px;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 15px;
        border: 2px solid rgba(255, 255, 255, 0.3);
        backdrop-filter: blur(10px);
    }
    
    .reset-form-icon i {
        font-size: 32px;
    }
    
    .reset-form-body {
        padding: 40px;
    }
    
    .user-info-box {
        background: linear-gradient(135deg, #f0f9ff 0%, #e6f7f0 100%);
        border: 2px solid #d1fae5;
        border-radius: 12px;
        padding: 20px;
        margin-bottom: 25px;
        text-align: center;
    }
    
    .user-email {
        font-size: 16px;
        font-weight: 600;
        color: #059669;
        word-break: break-all;
        padding: 8px 12px;
        background: white;
        border-radius: 8px;
        display: inline-block;
        margin-top: 5px;
        border: 1px solid #10b98120;
    }
    
    .password-input-group {
        position: relative;
        margin-bottom: 20px;
    }
    
    .password-input {
        padding-left: 50px !important;
        padding-right: 50px !important;
        height: 56px;
        border: 2px solid #e5e7eb;
        border-radius: 12px;
        font-size: 16px;
        transition: all 0.3s ease;
    }
    
    .password-input:focus {
        border-color: #10b981;
        box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.1);
        transform: translateY(-1px);
    }
    
    .password-input.valid {
        border-color: #10b981;
        background-color: #f0fdf4;
    }
    
    .password-input.invalid {
        border-color: #dc3545;
        background-color: #fff5f5;
    }
    
    .password-icon {
        position: absolute;
        left: 16px;
        top: 50%;
        transform: translateY(-50%);
        color: #10b981;
        font-size: 20px;
        z-index: 2;
    }
    
    .toggle-password {
        position: absolute;
        right: 16px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        color: #9ca3af;
        cursor: pointer;
        font-size: 18px;
        transition: color 0.3s ease;
    }
    
    .toggle-password:hover {
        color: #10b981;
    }
    
    .password-strength {
        margin-top: 8px;
        padding: 10px;
        background: #f8f9fa;
        border-radius: 8px;
        display: none;
    }
    
    .strength-meter {
        height: 4px;
        background: #e5e7eb;
        border-radius: 2px;
        margin-bottom: 5px;
        overflow: hidden;
    }
    
    .strength-fill {
        height: 100%;
        width: 0%;
        background: #dc3545;
        border-radius: 2px;
        transition: all 0.3s ease;
    }
    
    .strength-fill.weak { background: #dc3545; width: 33%; }
    .strength-fill.fair { background: #ffc107; width: 66%; }
    .strength-fill.good { background: #10b981; width: 100%; }
    
    .strength-text {
        font-size: 12px;
        color: #6b7280;
    }
    
    .requirements-list {
        list-style: none;
        padding-left: 0;
        margin-top: 15px;
    }
    
    .requirement-item {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 8px;
        font-size: 13px;
        color: #6b7280;
    }
    
    .requirement-item i {
        font-size: 14px;
        color: #9ca3af;
    }
    
    .requirement-item.valid i {
        color: #10b981;
    }
    
    .btn-reset-submit {
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
        margin-top: 10px;
    }
    
    .btn-reset-submit:hover {
        transform: translateY(-2px);
        box-shadow: 0 12px 24px rgba(16, 185, 129, 0.3);
        background: linear-gradient(to right, #0da271, #047857);
    }
    
    .btn-reset-submit:disabled {
        opacity: 0.7;
        transform: none;
        box-shadow: none;
    }
    
    .btn-reset-submit .spinner {
        display: none;
        width: 20px;
        height: 20px;
        border: 3px solid rgba(255, 255, 255, 0.3);
        border-radius: 50%;
        border-top-color: white;
        animation: spin 1s ease-in-out infinite;
    }
    
    .btn-reset-submit.loading .text {
        display: none;
    }
    
    .btn-reset-submit.loading .spinner {
        display: block;
    }
    
    .error-alert {
        background: #fff5f5;
        border: 2px solid #fecaca;
        border-radius: 12px;
        padding: 15px;
        margin-bottom: 20px;
        display: none;
        animation: fadeIn 0.3s ease-out;
    }
    
    .error-alert.show {
        display: block;
    }
    
    .error-alert i {
        color: #dc3545;
        font-size: 18px;
    }
    
    .back-to-login {
        text-align: center;
        margin-top: 25px;
        padding-top: 20px;
        border-top: 1px solid #e5e7eb;
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
    
    .security-note {
        background: #fff3cd;
        border: 1px solid #ffecb5;
        border-radius: 12px;
        padding: 15px;
        margin-top: 20px;
        font-size: 13px;
        color: #856404;
    }
    
    .security-note h6 {
        color: #856404;
        font-weight: 600;
        margin-bottom: 8px;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    
    @media (max-width: 576px) {
        .reset-form-card {
            margin: 0 15px;
        }
        
        .reset-form-body {
            padding: 30px 20px;
        }
        
        .reset-form-header {
            padding: 25px 20px 20px;
        }
    }
</style>

<div class="password-reset-form-container">
    <div class="reset-form-card">
        <!-- Header -->
        <div class="reset-form-header">
            <div class="reset-form-icon">
                <i class="ri-key-2-line"></i>
            </div>
            <h1 class="h3 fw-bold mb-2">Create New Password</h1>
            <p class="mb-0 opacity-90">Choose a strong, secure password</p>
        </div>
        
        <!-- Body -->
        <div class="reset-form-body">
            <!-- Error Alert -->
            <c:if test="${not empty error}">
                <div class="error-alert show">
                    <div class="d-flex align-items-start">
                        <i class="ri-error-warning-line me-2"></i>
                        <div>
                            <div class="fw-semibold">Error</div>
                            <div class="mt-1">${error}</div>
                        </div>
                    </div>
                </div>
            </c:if>
            
            <!-- User Info -->
            <div class="user-info-box">
                <p class="mb-2 text-muted">Setting new password for:</p>
                <div class="user-email">
                    <i class="ri-user-3-line me-2"></i>
                    <span id="userEmail">${email}</span>
                </div>
                <p class="text-muted fs-12 mt-2 mb-0">Ensure this is your official Lands Commission email</p>
            </div>
            
            <!-- Reset Form -->
            <form id="resetPasswordForm" method="POST" action="perform-password-reset" novalidate>
                <input type="hidden" name="token" value="${token}">
                <input type="hidden" name="email" value="${email}">
                
                <!-- New Password -->
                <div class="form-group">
                    <label class="form-label fw-semibold mb-2">
                        <i class="ri-lock-line"></i>
                        <span>New Password</span>
                    </label>
                    <div class="password-input-group">
                        <i class="ri-lock-password-line password-icon"></i>
                        <input type="password" 
                               class="form-control password-input" 
                               id="newPassword" 
                               name="newPassword" 
                               placeholder="Enter new password" 
                               required
                               minlength="14"
                               pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{14,}$">
                        <button type="button" class="toggle-password" data-target="newPassword">
                            <i class="ri-eye-off-line"></i>
                        </button>
                    </div>
                    
                    <!-- Password Strength Meter -->
                    <div class="password-strength" id="passwordStrength">
                        <div class="strength-meter">
                            <div class="strength-fill" id="strengthFill"></div>
                        </div>
                        <div class="strength-text" id="strengthText">Password strength: Very weak</div>
                    </div>
                    
                    <!-- Password Requirements -->
                    <ul class="requirements-list" id="passwordRequirements">
                        <li class="requirement-item" id="reqLength">
                            <i class="ri-checkbox-blank-circle-line"></i>
                            <span>At least 14 characters</span>
                        </li>
                        <li class="requirement-item" id="reqLowercase">
                            <i class="ri-checkbox-blank-circle-line"></i>
                            <span>One lowercase letter</span>
                        </li>
                        <li class="requirement-item" id="reqUppercase">
                            <i class="ri-checkbox-blank-circle-line"></i>
                            <span>One uppercase letter</span>
                        </li>
                        <li class="requirement-item" id="reqNumber">
                            <i class="ri-checkbox-blank-circle-line"></i>
                            <span>One number</span>
                        </li>
                        <li class="requirement-item" id="reqSpecial">
                            <i class="ri-checkbox-blank-circle-line"></i>
                            <span>One special character (@$!%*?&)</span>
                        </li>
                    </ul>
                </div>
                
                <!-- Confirm Password -->
                <div class="form-group">
                    <label class="form-label fw-semibold mb-2">
                        <i class="ri-lock-unlock-line"></i>
                        <span>Confirm New Password</span>
                    </label>
                    <div class="password-input-group">
                        <i class="ri-lock-unlock-line password-icon"></i>
                        <input type="password" 
                               class="form-control password-input" 
                               id="confirmPassword" 
                               name="confirmPassword" 
                               placeholder="Re-enter new password" 
                               required>
                        <button type="button" class="toggle-password" data-target="confirmPassword">
                            <i class="ri-eye-off-line"></i>
                        </button>
                    </div>
                    <div class="form-text text-muted fs-12 mt-2" id="passwordMatchText">
                        <i class="ri-information-line me-1"></i>
                        Passwords must match
                    </div>
                </div>
                
                <!-- Submit Button -->
                <div class="d-grid mb-3">
                    <button type="submit" id="btnResetSubmit" class="btn btn-reset-submit">
                        <span class="text">Reset Password</span>
                        <span class="spinner"></span>
                    </button>
                </div>
            </form>
            
            <!-- Back to Login -->
            <div class="back-to-login">
                <a href="/" class="back-link">
                    <i class="ri-arrow-left-line"></i>
                    <span>Back to Login</span>
                </a>
            </div>
            
            <!-- Security Note -->
            <div class="security-note">
                <h6>
                    <i class="ri-shield-keyhole-line"></i>
                    Security Guidelines
                </h6>
                <div class="fs-13">
                    <p class="mb-2">For your security, please:</p>
                    <ul class="mb-0 ps-3 small fw-light">
                        <li class="mb-1">Use a unique password not used elsewhere</li>
                        <li class="mb-1">Avoid using personal information</li>
                        <li>Consider using a password manager</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Security warning
        console.log("%c🔐 PASSWORD RESET PORTAL 🔐", "color: #10b981; font-size: 18px; font-weight: bold;");
        console.log("%cYou are setting a new password. Ensure it meets all security requirements.", "color: #fff; background: #059669; padding: 5px;");
        
        // Toggle password visibility
        $('.toggle-password').on('click', function() {
            const targetId = $(this).data('target');
            const input = $('#' + targetId);
            const icon = $(this).find('i');
            
            if (input.attr('type') === 'password') {
                input.attr('type', 'text');
                icon.removeClass('ri-eye-off-line');
                icon.addClass('ri-eye-line');
            } else {
                input.attr('type', 'password');
                icon.removeClass('ri-eye-line');
                icon.addClass('ri-eye-off-line');
            }
        });
        
        // Password strength checker
        $('#newPassword').on('input', function() {
            const password = $(this).val();
            const strengthMeter = $('#passwordStrength');
            const strengthFill = $('#strengthFill');
            const strengthText = $('#strengthText');
            
            // Show strength meter if password has content
            if (password.length > 0) {
                strengthMeter.show();
            } else {
                strengthMeter.hide();
                return;
            }
            
            // Check requirements
            const hasLength = password.length >= 14;
            const hasLowercase = /[a-z]/.test(password);
            const hasUppercase = /[A-Z]/.test(password);
            const hasNumber = /\d/.test(password);
            const hasSpecial = /[@$!%*?&]/.test(password);
            
            // Update requirement icons
            updateRequirement('reqLength', hasLength);
            updateRequirement('reqLowercase', hasLowercase);
            updateRequirement('reqUppercase', hasUppercase);
            updateRequirement('reqNumber', hasNumber);
            updateRequirement('reqSpecial', hasSpecial);
            
            // Calculate strength score
            let score = 0;
            if (hasLength) score += 1;
            if (hasLowercase) score += 1;
            if (hasUppercase) score += 1;
            if (hasNumber) score += 1;
            if (hasSpecial) score += 1;
            
            // Update strength meter
            strengthFill.removeClass('weak fair good');
            
            if (score <= 2) {
                strengthFill.addClass('weak');
                strengthText.text('Password strength: Weak');
                strengthText.css('color', '#dc3545');
            } else if (score <= 4) {
                strengthFill.addClass('fair');
                strengthText.text('Password strength: Fair');
                strengthText.css('color', '#ffc107');
            } else {
                strengthFill.addClass('good');
                strengthText.text('Password strength: Strong');
                strengthText.css('color', '#10b981');
            }
            
            // Validate password
            validatePassword(password);
        });
        
        // Update requirement status
        function updateRequirement(elementId, isValid) {
            const element = $('#' + elementId);
            const icon = element.find('i');
            
            if (isValid) {
                element.addClass('valid');
                icon.removeClass('ri-checkbox-blank-circle-line');
                icon.addClass('ri-checkbox-circle-line');
                element.css('color', '#10b981');
            } else {
                element.removeClass('valid');
                icon.removeClass('ri-checkbox-circle-line');
                icon.addClass('ri-checkbox-blank-circle-line');
                element.css('color', '#6b7280');
            }
        }
        
        // Password validation
        function validatePassword(password) {
            const input = $('#newPassword');
            const hasLength = password.length >= 14;
            const hasLowercase = /[a-z]/.test(password);
            const hasUppercase = /[A-Z]/.test(password);
            const hasNumber = /\d/.test(password);
            const hasSpecial = /[@$!%*?&]/.test(password);
            
            if (password.length === 0) {
                input.removeClass('valid invalid');
            } else if (hasLength && hasLowercase && hasUppercase && hasNumber && hasSpecial) {
                input.addClass('valid');
                input.removeClass('invalid');
            } else {
                input.addClass('invalid');
                input.removeClass('valid');
            }
        }
        
        // Password matching validation
        $('#confirmPassword').on('input', function() {
            const newPassword = $('#newPassword').val();
            const confirmPassword = $(this).val();
            const matchText = $('#passwordMatchText');
            
            if (confirmPassword.length === 0) {
                matchText.html('<i class="ri-information-line me-1"></i> Passwords must match');
                matchText.css('color', '#6b7280');
                $(this).removeClass('valid invalid');
                return;
            }
            
            if (newPassword === confirmPassword) {
                matchText.html('<i class="ri-check-line me-1"></i> Passwords match');
                matchText.css('color', '#10b981');
                $(this).addClass('valid');
                $(this).removeClass('invalid');
            } else {
                matchText.html('<i class="ri-close-line me-1"></i> Passwords do not match');
                matchText.css('color', '#dc3545');
                $(this).addClass('invalid');
                $(this).removeClass('valid');
            }
        });
        
        // Form submission
        $('#resetPasswordForm').on('submit', function(e) {
            e.preventDefault();
            
            const btn = $('#btnResetSubmit');
            const newPassword = $('#newPassword').val();
            const confirmPassword = $('#confirmPassword').val();
            
            // Validate password strength
            const hasLength = newPassword.length >= 14;
            const hasLowercase = /[a-z]/.test(newPassword);
            const hasUppercase = /[A-Z]/.test(newPassword);
            const hasNumber = /\d/.test(newPassword);
            const hasSpecial = /[@$!%*?&]/.test(newPassword);
            
            if (!hasLength || !hasLowercase || !hasUppercase || !hasNumber || !hasSpecial) {
                Swal.fire({
                    title: 'Password Requirements Not Met',
                    html: 'Your password must contain:<br>' +
                          '• At least 14 characters<br>' +
                          '• One lowercase letter<br>' +
                          '• One uppercase letter<br>' +
                          '• One number<br>' +
                          '• One special character (@$!%*?&)',
                    icon: 'warning',
                    confirmButtonColor: '#10b981'
                });
                return;
            }
            
            // Check if passwords match
            if (newPassword !== confirmPassword) {
                Swal.fire({
                    title: 'Passwords Do Not Match',
                    text: 'Please ensure both password fields match exactly.',
                    icon: 'error',
                    confirmButtonColor: '#10b981'
                });
                return;
            }
            
            // Show loading state
            btn.addClass('loading');
            btn.prop('disabled', true);
            
            // Submit form after validation
            setTimeout(() => {
                this.submit();
            }, 1000);
        });
        
        // Auto-focus on password input
        setTimeout(() => {
            $('#newPassword').focus();
        }, 500);
    });
</script>