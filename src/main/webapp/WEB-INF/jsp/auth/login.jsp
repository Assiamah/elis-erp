<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<style>
    .login-gradient-bg {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
    }

    .glass-effect {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .input-group-custom {
        transition: all 0.3s ease;
        border-radius: 8px;
    }

    .input-group-custom:focus-within {
        border-color: #10b981;
        box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
        transform: translateY(-1px);
    }

    .btn-primary-gradient {
        background: linear-gradient(to right, #10b981, #059669);
        border: none;
        transition: all 0.3s ease;
        color: white;
    }

    .btn-primary-gradient:hover {
        transform: translateY(-2px);
        box-shadow: 0 10px 20px rgba(16, 185, 129, 0.3);
        background: linear-gradient(to right, #059669, #047857);
    }

    .btn-primary-gradient:disabled {
        background: linear-gradient(to right, #a7f3d0, #6ee7b7);
        transform: none;
        box-shadow: none;
    }

    .floating-label {
        position: absolute;
        top: 50%;
        left: 12px;
        transform: translateY(-50%);
        transition: all 0.3s ease;
        pointer-events: none;
        color: #6b7280;
        font-size: 14px;
    }

    .floating-input {
        padding-top: 24px !important;
        padding-bottom: 8px !important;
    }

    .floating-input:focus + .floating-label,
    .floating-input:not(:placeholder-shown) + .floating-label {
        top: 2px;
        left: 10px;
        font-size: 12px;
        color: #059669;
        background: white;
        padding: 0 5px;
        font-weight: 500;
    }

    .auth-sidebar {
        position: relative;
        overflow: hidden;
    }

    .auth-sidebar::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, rgba(16, 185, 129, 0.9), rgba(5, 150, 105, 0.9));
        z-index: 1;
    }

    .auth-sidebar-content {
        position: relative;
        z-index: 2;
        min-height: 100vh;
    }

    .pulse-animation {
        animation: pulse 2s infinite;
    }

    @keyframes pulse {
        0% {
            box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.4);
        }
        70% {
            box-shadow: 0 0 0 10px rgba(16, 185, 129, 0);
        }
        100% {
            box-shadow: 0 0 0 0 rgba(16, 185, 129, 0);
        }
    }

    .pattern-dots {
        background-image: radial-gradient(rgba(255, 255, 255, 0.1) 1px, transparent 1px);
        background-size: 20px 20px;
        height: 100%;
    }
    
    .glass-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        transition: all 0.3s ease;
        border-radius: 12px;
    }
    
    .glass-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1) !important;
        border-color: rgba(16, 185, 129, 0.3);
    }
    
    .icon-wrapper {
        transition: all 0.3s ease;
    }
    
    .glass-card:hover .icon-wrapper {
        transform: scale(1.1);
        background-color: rgba(16, 185, 129, 0.15) !important;
    }
    
    .auth-sidebar {
        background: linear-gradient(135deg, #0d966b 0%, #0a7c56 100%);
    }
    
    .auth-sidebar::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: linear-gradient(135deg, 
            rgba(13, 150, 107, 0.95), 
            rgba(10, 124, 86, 0.95));
        z-index: 1;
    }
    
    .auth-sidebar-content {
        position: relative;
        z-index: 2;
    }
    
    .bg-opacity-10 {
        background-color: rgba(var(--bs-white-rgb), 0.1) !important;
    }
    
    .bg-opacity-25 {
        background-color: rgba(var(--bs-white-rgb), 0.25) !important;
    }
    
    .border-opacity-25 {
        border-color: rgba(var(--bs-white-rgb), 0.25) !important;
    }
    
    .badge {
        border-radius: 8px;
        font-weight: 500;
    }
    
    .alert-light {
        background-color: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
    }
</style>

<div class="container-fluid min-vh-100 p-0">
    <div class="row g-0 h-100">
        <!-- Left Side - Login Form -->
        <div class="col-lg-6 d-flex align-items-center justify-content-center p-4 p-lg-5">
            <div class="w-100" style="max-width: 420px;">
                <!-- Logo & Brand -->
                <div class="text-center mb-5">
                    <div class="d-inline-block p-3 rounded-circle bg-light mb-3 pulse-animation">
                        <img src="${pageContext.request.contextPath}/assets/images/NewLogo.jpg" 
                             width="70" alt="logo" class="rounded-circle">
                    </div>
                    <h1 class="h4 fw-bold text-dark mb-1">Enterprise Land Information System</h1>
                    <!-- <p class="text-muted fs-14">Secure Access Portal</p> -->
                </div>

                <!-- Login Card -->
                <div class="card border-0 shadow-lg glass-effect">
                    <div class="card-body p-4 p-lg-5">

                        <!-- Welcome Text -->
                        <div class="text-center mb-4">
                            <h2 class="h5 fw-bold text-dark mb-2">Welcome Back</h2>
                            <p class="text-muted fs-14">Please sign in to continue</p>
                        </div>

                        <!-- Error Alert -->
                        <c:if test="${login == 'failed'}">
                            <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center mb-4" role="alert">
                                <div class="flex-shrink-0">
                                    <i class="ri-error-warning-line fs-20"></i>
                                </div>
                                <div class="flex-grow-1 ms-3">
                                    <h6 class="alert-heading fw-semibold mb-1">Authentication Failed</h6>
                                    <p class="mb-0 fs-13">Invalid credentials. Please check your email and password.</p>
                                </div>
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Login Form -->
                        <form name="loginForm" id="loginForm" method="POST" action="two_factor_verification" novalidate>
                            <!-- Email Field -->
                            <div class="mb-4">
                                <div class="position-relative">
                                    <input type="email" 
                                           class="form-control form-control-lg floating-input ps-4" 
                                           name="email" 
                                           id="email" 
                                           placeholder=" "
                                           required>
                                    <label for="email" class="floating-label">
                                        <i class="ri-mail-line me-2"></i>Email Address
                                    </label>
                                    <!-- <div class="position-absolute end-0 top-50 translate-middle-y me-4">
                                        <i class="ri-user-3-line text-muted"></i>
                                    </div> -->
                                </div>
                            </div>

                            <!-- Password Field -->
                            <div class="mb-4">
                                <div class="position-relative">
                                    <input type="password" 
                                           class="form-control form-control-lg floating-input ps-4" 
                                           name="password" 
                                           id="password" 
                                           placeholder=" "
                                           required>
                                    <label for="password" class="floating-label">
                                        <i class="ri-lock-line me-2"></i>Password
                                    </label>
                                    <button type="button" 
                                            class="btn btn-link position-absolute end-0 top-50 translate-middle-y text-decoration-none"
                                            onclick="togglePassword('password', this)">
                                        <i class="ri-eye-off-line align-middle text-muted"></i>
                                    </button>
                                </div>
                            </div>

                            <!-- Remember Me & Forgot Password -->
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="rememberMe">
                                    <label class="form-check-label fs-14" for="rememberMe">
                                        Remember this device
                                    </label>
                                </div>
                                <a href="reset-password-basic.html" class="text-decoration-none fs-14 text-primary fw-medium">
                                    Forgot Password?
                                </a>
                            </div>

                            <!-- Submit Button -->
                            <div class="mb-4">
                                <button type="submit" 
                                        id="btn-login" 
                                        class="btn btn-primary btn-lg w-100 ">
                                    <span class="login-text">
                                        <i class="ri-login-box-line me-2"></i>
                                        Sign In
                                    </span>
                                    <span class="loading-text d-none">
                                        <span class="mdi mdi-spin mdi-loading me-1" role="status"></span>
                                        Authenticating...
                                    </span>
                                </button>
                            </div>

                            <!-- Divider -->
                            <!-- <div class="position-relative text-center my-4">
                                <hr class="text-muted">
                                <span class="position-absolute top-50 start-50 translate-middle bg-white px-3 text-muted fs-12">
                                    OR
                                </span>
                            </div> -->

                            <!-- Alternative Login -->
                            <!-- <div class="text-center">
                                <p class="text-muted fs-14 mb-3">Sign in with</p>
                                <div class="d-flex justify-content-center gap-3">
                                    <a href="#" class="btn btn-outline-light border text-dark rounded-circle p-2">
                                        <i class="ri-google-fill fs-18"></i>
                                    </a>
                                    <a href="#" class="btn btn-outline-light border text-dark rounded-circle p-2">
                                        <i class="ri-microsoft-fill fs-18"></i>
                                    </a>
                                    <a href="#" class="btn btn-outline-light border text-dark rounded-circle p-2">
                                        <i class="ri-github-fill fs-18"></i>
                                    </a>
                                </div>
                            </div> -->
                        </form>
                    </div>
                </div>

                <!-- Help Link -->
                <div class="text-center mt-4">
                    <p class="text-muted fs-13 mb-0">
                        Need help signing in?
                        <a href="#" class="text-primary fw-medium text-decoration-none ms-1">
                            Contact Support
                        </a>
                    </p>
                </div>

                <!-- Footer -->
                <div class="text-center mt-5">
                    <p class="text-muted fs-12 mb-0">
                        © 2024 Lands Commission. All rights reserved.
                        <a href="#" class="text-muted text-decoration-underline ms-1">Privacy Policy</a>
                    </p>
                </div>
            </div>
        </div>

        <!-- Right Side - Welcome Panel -->
        <div class="col-lg-6 auth-sidebar d-none d-lg-flex align-items-center justify-content-center position-relative ">
            <!-- Background Pattern -->
            <div class="position-absolute top-0 start-0 w-100 h-100 opacity-10">
                <div class="pattern-dots"></div>
            </div>
            
            <div class="auth-sidebar-content text-center p-4 p-lg-5" style="max-width: 650px;">

                <!-- Four White Cards Grid -->
                <div class="row g-4 mb-5">
                    <!-- Card 1: Security -->
                    <div class="col-md-6">
                        <div class="card border-0 shadow-lg h-100 glass-card">
                            <div class="card-body p-4 text-center">
                                <div class="icon-wrapper bg-success bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                                    <i class="ri-shield-check-line fs-32 text-success"></i>
                                </div>
                                <h6 class="fw-semibold mb-2">Military-Grade Security</h6>
                                <p class="text-muted fs-13 mb-0">
                                    Advanced encryption and multi-factor authentication protect your sensitive data
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Card 2: Reliability -->
                    <div class="col-md-6">
                        <div class="card border-0 shadow-lg h-100 glass-card">
                            <div class="card-body p-4 text-center">
                                <div class="icon-wrapper bg-info bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                                    <i class="ri-server-line fs-32 text-info"></i>
                                </div>
                                <h6 class="fw-semibold mb-2">99.9% Uptime</h6>
                                <p class="text-muted fs-13 mb-0">
                                    Guaranteed system availability with real-time monitoring and automatic failover
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Card 3: Data Management -->
                    <div class="col-md-6">
                        <div class="card border-0 shadow-lg h-100 glass-card">
                            <div class="card-body p-4 text-center">
                                <div class="icon-wrapper bg-warning bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                                    <i class="ri-database-2-line fs-32 text-warning"></i>
                                </div>
                                <h6 class="fw-semibold mb-2">Centralized Data Hub</h6>
                                <p class="text-muted fs-13 mb-0">
                                    Unified platform for all land records with advanced search and analytics capabilities
                                </p>
                            </div>
                        </div>
                    </div>

                    <!-- Card 4: Support -->
                    <div class="col-md-6">
                        <div class="card border-0 shadow-lg h-100 glass-card">
                            <div class="card-body p-4 text-center">
                                <div class="icon-wrapper bg-primary bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                                    <i class="ri-customer-service-2-line fs-32 text-primary"></i>
                                </div>
                                <h6 class="fw-semibold mb-2">24/7 Expert Support</h6>
                                <p class="text-muted fs-13 mb-0">
                                    Dedicated support team available round the clock for immediate assistance
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- System Stats -->
                <div class="row g-3 mb-5">
                    <div class="col-4">
                        <div class="text-center">
                            <h3 class="text-white fw-bold mb-1">10K+</h3>
                            <p class="text-white opacity-75 fs-12 mb-0">Active Users</p>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="text-center">
                            <h3 class="text-white fw-bold mb-1">50M+</h3>
                            <p class="text-white opacity-75 fs-12 mb-0">Records</p>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="text-center">
                            <h3 class="text-white fw-bold mb-1">99.9%</h3>
                            <p class="text-white opacity-75 fs-12 mb-0">Satisfaction</p>
                        </div>
                    </div>
                </div>

                <!-- Security Banner -->
                <div class="alert alert-light border-0 shadow-sm mb-4" role="alert">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0 me-3">
                            <i class="ri-shield-flash-fill fs-20 text-danger"></i>
                        </div>
                        <div class="flex-grow-1 text-start">
                            <h6 class="alert-heading mb-1 fw-semibold text-dark">Security Reminder</h6>
                            <p class="mb-0 fs-13 text-dark">
                                Your security is our priority. Always verify you're on the official ELIS portal before entering credentials.
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="border-top border-white border-opacity-25 pt-4">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="text-start">
                            <p class="text-white opacity-75 fs-12 mb-1">
                                <i class="ri-shield-check-line me-1"></i>
                                <span class="fw-medium">Verified Secure Connection</span>
                            </p>
                            <p class="text-white opacity-75 fs-12 mb-0">
                                <i class="ri-time-line me-1"></i>
                                Last updated: Just now
                            </p>
                        </div>
                        <div class="text-end">
                            <div class="badge bg-warning bg-opacity-25 text-warning border border-warning border-opacity-25 py-2 px-3">
                                <i class="ri-checkbox-circle-fill me-1"></i>
                                All Systems Operational
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Security warning
        console.log("%c⚠️ SECURITY WARNING ⚠️", "color: #ff6b6b; font-size: 20px; font-weight: bold;");
        console.log("%cThis is a browser feature intended for developers. Do not enter any information here.", "color: #fff; background: #dc3545; padding: 5px;");
        
        // Password toggle
        window.togglePassword = function(inputId, button) {
            const input = document.getElementById(inputId);
            const icon = button.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.remove('ri-eye-off-line');
                icon.classList.add('ri-eye-line');
            } else {
                input.type = 'password';
                icon.classList.remove('ri-eye-line');
                icon.classList.add('ri-eye-off-line');
            }
        };
        
        // Form submission handler
        $('#loginForm').on('submit', function(e) {
            const btn = $('#btn-login');
            const loginText = btn.find('.login-text');
            const loadingText = btn.find('.loading-text');
            
            if (this.checkValidity()) {
                loginText.addClass('d-none');
                loadingText.removeClass('d-none');
                btn.prop('disabled', true).addClass('disabled');
            }
        });
        
        // Input validation styling
        // $('.floating-input').on('blur', function() {
        //     if (this.value) {
        //         $(this).addClass('is-valid');
        //     } else {
        //         $(this).removeClass('is-valid');
        //     }
        // });
        
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            $('.alert-dismissible').alert('close');
        }, 5000);
    });
</script>